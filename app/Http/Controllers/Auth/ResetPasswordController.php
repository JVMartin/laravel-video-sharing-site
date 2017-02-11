<?php

namespace App\Http\Controllers\Auth;

use Auth;
use App\Services\AuthManager;
use Illuminate\Database\Connection;
use App\Repositories\UserRepository;
use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\ResetsPasswords;
use Illuminate\Auth\Passwords\DatabaseTokenRepository;

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
	 * @var DatabaseTokenRepository
	 */
	protected $tokenRepository;

	/**
	 * @var AuthManager
	 */
	protected $authManager;

	public function __construct(
		Connection $db,
		UserRepository $userRepository,
		DatabaseTokenRepository $tokenRepository,
		AuthManager $authManager
	)
	{
		$this->db = $db;
		$this->userRepository = $userRepository;
		$this->tokenRepository = $tokenRepository;
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

		// First, delete expired tokens.
		$this->broker()->getRepository()->deleteExpired();

		if ( ! strlen($hashid) || ! strlen($token)) {
			return $this->failedResponse();
		}

		$user = $this->userRepository->getByHashId($hashid);

		if ( ! $user || ! $this->tokenRepository->exists($user, $token)) {
			return $this->failedResponse();
		}

		$this->tokenRepository->delete($user);

		$this->authManager->signIn($user);

		successMessage('You have been signed in.  Use the form below to reset your password.');
		return redirect()->route('account.password');
	}

	/**
	 * @return \Illuminate\Http\RedirectResponse
	 */
	private function failedResponse()
	{
		errorMessage('The link you used is expired or malformed.');
		return redirect()->route('home');
	}
}
