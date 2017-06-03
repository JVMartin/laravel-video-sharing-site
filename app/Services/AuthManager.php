<?php

namespace App\Services;

use Socialite;
use Exception;
use Google_Client;
use App\Models\User;
use Google_Service_Oauth2;
use App\Jobs\DownloadAvatar;
use App\Repositories\UserRepository;
use Google_Service_Oauth2_Userinfoplus;
use App\Events\EmailRequiresVerification;
use App\Repositories\VerificationRepository;
use Illuminate\Foundation\Auth\AuthenticatesUsers;

class AuthManager
{
	use AuthenticatesUsers;

	/**
	 * @var UserRepository
	 */
	protected $userRepository;

	/**
	 * @var VerificationRepository
	 */
	protected $verificationRepository;

	public function __construct(
		UserRepository $userRepository,
		VerificationRepository $verificationRepository
	)
	{
		$this->userRepository = $userRepository;
		$this->verificationRepository = $verificationRepository;
	}

	/**
	 * Sign in a given user, or attempt to sign in with user-supplied credentials.
	 *
	 * @param User|array $credentials
	 * @param bool $remember
	 * @return mixed A boolean if credentials are passed in, otherwise void.
	 */
	public function signIn($credentials, $remember = false)
	{
		if (is_array($credentials)) {
			return $this->guard()->attempt($credentials, $remember);
		}
		if ($credentials instanceof User) {
			$this->guard()->login($credentials, $remember);
		}
	}

	/**
	 * Sign out the currently signed-in user.
	 */
	public function signOut()
	{
		$this->guard()->logout();
		session()->flush();
		session()->regenerate();
	}

	/**
	 * Register for an account.
	 *
	 * @param array $data
	 * @return User
	 */
	public function register($data)
	{
		$user = $this->userRepository->create($data);
		event(new EmailRequiresVerification($user));
		$this->signIn($user);
		return $user;
	}

	/**
	 * Verify an email.  All we have to do is delete the verification row.
	 *
	 * @param string $token
	 * @return bool
	 */
	public function verify($token)
	{
		$verification = $this->verificationRepository->getByToken($token);

		if ( ! $verification) {
			return false;
		}

		$this->verificationRepository->deleteByToken($token);
		return true;
	}

	/**
	 * Redirect the user to sign in with Facebook.
	 *
	 * @return \Illuminate\Http\RedirectResponse
	 */
	public function redirectFacebook()
	{
		return Socialite::driver('facebook')->redirect();
	}

	/**
	 * Redirect the user to sign in with Google.
	 *
	 * @return \Illuminate\Http\RedirectResponse
	 */
	public function redirectGoogle()
	{
		return redirect($this->googleClient()->createAuthUrl());
	}

	/**
	 * @return User
	 * @throws Exception When Facebook doesn't give us an email.
	 */
	public function callbackFacebook()
	{
		$fbUser = Socialite::driver('facebook')->user();

		if ( ! strlen($fbUser->email)) {
			throw new Exception('Facebook did not return an email.');
		}

		$user = $this->userRepository->getByEmail($fbUser->email);
		if ( ! $user) {
			$user = $this->userRepository->create([
				'email' => $fbUser->email
			]);
			$this->fillFacebookUser($user, $fbUser);
		}

		return $user;
	}

	/**
	 * @param User $user
	 * @param \Laravel\Socialite\Two\User $fbUser
	 */
	private function fillFacebookUser(User $user, $fbUser)
	{
		$nameParts = explode(' ', $fbUser->name);

		// Parse their first and last name.
		$first_name = (count($nameParts)) ? $nameParts[0] : null;
		if (count($nameParts) > 1) {
			$lastParts = array_slice($nameParts, 1);
			$last_name = implode(' ', $lastParts);
		}
		else {
			$last_name = null;
		}

		$updates = [];

		if ( ! strlen($user->first_name)) $updates['first_name'] = $first_name;
		if ( ! strlen($user->last_name)) $updates['last_name'] = $last_name;

		$this->userRepository->update($user, $updates);

		// Save their avatar.
		dispatch(new DownloadAvatar($user, $fbUser->avatar_original));
	}

	/**
	 * @param $code string The authorization code.
	 * @return User $user The Google authenticated user.
	 * @throws Exception When Google doesn't give us an email.
	 */
	public function callbackGoogle($code)
	{
		$this->googleClient()->fetchAccessTokenWithAuthCode($code);
		$googleAuth = new Google_Service_Oauth2($this->googleClient());
		$googleUser = $googleAuth->userinfo->get();

		if ( ! strlen($googleUser->email)) {
			throw new Exception('Google authorization did not return an email.');
		}

		$user = $this->userRepository->getByEmail($googleUser->email);
		if ( ! $user) {
			$user = $this->userRepository->create([
				'email' => $googleUser->email
			]);
			$this->fillGoogleUser($user, $googleUser);
		}

		return $user;
	}

	/**
	 * @param User $user
	 * @param Google_Service_Oauth2_Userinfoplus $googleUser
	 */
	private function fillGoogleUser(User $user, Google_Service_Oauth2_Userinfoplus $googleUser)
	{
		$updates = [];

		if ( ! strlen($user->first_name)) $updates['first_name'] = $googleUser->givenName;
		if ( ! strlen($user->last_name)) $updates['last_name'] = $googleUser->familyName;

		$this->userRepository->update($user, $updates);

		// Save their avatar.
		dispatch(new DownloadAvatar($user, $googleUser->picture));
	}

	/**
	 * @return Google_Client
	 */
	private function googleClient()
	{
		static $google = null;
		if ($google === null) {
			$google = new Google_Client();
			$google->setClientId(env('GOOGLE_CLIENT_ID'));
			$google->setClientSecret(env('GOOGLE_CLIENT_SECRET'));
			$google->setRedirectUri(env('GOOGLE_REDIRECT'));
			$google->setScopes(['email', 'profile']);
		}
		return $google;
	}
}
