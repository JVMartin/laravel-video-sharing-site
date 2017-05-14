<?php

namespace App\Http\Controllers\Auth;

use Auth;
use App\Services\AuthManager;
use Illuminate\Database\Connection;
use App\Repositories\UserRepository;
use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\ResetsPasswords;

class ResetPasswordController extends Controller
{
	use ResetsPasswords;

	/**
	 * @var Connection
	 */
	protected $db;

	/**
	 * @var UserRepository
	 */
	protected $userRepository;

	/**
	 * @var AuthManager
	 */
	protected $authManager;

	public function __construct(
		Connection $db,
		UserRepository $userRepository,
		AuthManager $authManager
	)
	{
		$this->middleware('guest');

		$this->db = $db;
		$this->userRepository = $userRepository;
		$this->authManager = $authManager;
	}

	/**
	 * Sign the user in and redirect them to the password reset account page.
	 *
	 * @param string|null $token
	 * @return \Illuminate\Http\RedirectResponse
	 */
	public function getReset($hashid = null, $token = null)
	{
		if (Auth::check()) {
			// Only weirdos should ever see this.
			errorMessage('You must first sign out before using a password reset link.');
			return redirect()->route('home');
		}

		$tokenRepository = $this->broker()->getRepository();

		// First, delete expired tokens.
		$tokenRepository->deleteExpired();

		if ( ! strlen($hashid) || ! strlen($token)) {
			return $this->failedResponse();
		}

		$user = $this->userRepository->getByHashId($hashid);

		if ( ! $user || ! $tokenRepository->exists($user, $token)) {
			return $this->failedResponse();
		}

		$tokenRepository->delete($user);

		$this->authManager->signIn($user);

		successMessage(trans('auth.forgot-pass.email-used'));
		return redirect()->route('account.password');
	}

	/**
	 * @return \Illuminate\Http\RedirectResponse
	 */
	private function failedResponse()
	{
		errorMessage(trans('auth.forgot-pass.invalid-link'));
		return redirect()->route('home');
	}
}
