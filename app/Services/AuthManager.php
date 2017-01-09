<?php

namespace App\Services;

use DB;
use Imagick;
use Exception;
use Socialite;
use Google_Client;
use App\Models\User;
use Google_Service_Oauth2;
use App\Repositories\UserRepository;
use Google_Service_Oauth2_Userinfoplus;

class AuthManager
{
	/**
	 * @var UserRepository
	 */
	protected $userRepository;

	public function __construct(UserRepository $userRepository)
	{
		$this->userRepository = $userRepository;
	}

	public function redirectFacebook()
	{
		return Socialite::driver('facebook')->redirect();
	}

	public function redirectGoogle()
	{
		return redirect($this->googleClient()->createAuthUrl());
	}

	public function callbackFacebook()
	{
		$user = Socialite::driver('facebook')->user();

		dd($user);
	}

	/**
	 * @param $code string The authorization code.
	 * @throws Exception When Google doesn't give us an email.
	 */
	public function callbackGoogle($code)
	{
		$this->googleClient()->authenticate($code);
		$googleAuth = new Google_Service_Oauth2($this->googleClient());
		$googleUser = $googleAuth->userinfo->get();

		if ( ! strlen($googleUser->email)) {
			throw new Exception('Google authorization did not return an email.');
		}

		$user = $this->userRepository->getByEmail($googleUser->email);
		if ( ! $user) {
			DB::transaction(function() use (&$user, $googleUser) {
				$id = DB::table('users')->max('id') + 1;
				$user = $this->userRepository->create([
					'email'    => $googleUser->email,
					'username' => 'Anonymous' . encodeHash($id)
				]);
			});
		}
		$this->fillGoogleUser($user, $googleUser);
	}

	/**
	 * @param User $user
	 * @param Google_Service_Oauth2_Userinfoplus $googleUser
	 */
	private function fillGoogleUser(User $user, Google_Service_Oauth2_Userinfoplus $googleUser)
	{
//		if ( ! strlen($user->email)) $user->email           = $googleUser->email;
		if ( ! strlen($user->first_name)) $user->first_name = $googleUser->givenName;
		if ( ! strlen($user->last_name)) $user->last_name   = $googleUser->familyName;
		$user->save();

		// Save their avatar.
		$this->saveAvatar($user, $googleUser->picture);
	}

	/**
	 * @param User $user
	 * @param string $url
	 */
	private function saveAvatar(User $user, $url)
	{
		if ( ! strlen($url)) {
			return;
		}

		$destFile = public_path('img/u/' . $user->hash . '/avatar-o.jpg');
		$resized = public_path('img/u/' . $user->hash . '/avatar.jpg');

		// It's already been saved, no need to do so again.
		if (file_exists($destFile)) {
			return;
		}

		// Download the image.
		copy($url, $destFile);

		// Turn it into a 200 x 200 square.
		$image = new Imagick($destFile);
		$image->cropThumbnailImage(200, 200);
		$image->writeImage($resized);
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