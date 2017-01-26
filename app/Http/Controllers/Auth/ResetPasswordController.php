<?php

namespace App\Http\Controllers\Auth;

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
	public function getReset($token = null)
	{
		// First, delete expired tokens.
		$this->broker()->getRepository()->deleteExpired();

		if ( ! strlen($token)) {
			return $this->failedResponse();
		}

		$reset = $this->db->table('password_resets')
				->where('token', $token)
				->first();
		if ( ! $reset) {
			return $this->failedResponse();
		}

		$user = $this->userRepository->getByEmail($reset->email);

		$this->db->table('password_resets')
			->where('token', $token)
			->delete();

		if ( ! $user) {
			return $this->failedResponse();
		}

		$this->authManager->signIn($user);

		successMessage('You have been signed in.  Use the form below to reset your password.');
		return redirect()->route('account.password');
	}

	/**
	 * @return \Illuminate\Http\RedirectResponse
	 */
	public function failedResponse()
	{
		errorMessage('The link you used is expired or malformed.');
		return redirect()->route('home');
	}
}
