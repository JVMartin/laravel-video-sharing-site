<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Http\Request;
use App\Services\AuthManager;
use App\Http\Controllers\Controller;

class VerificationController extends Controller
{
	/**
	 * @var AuthManager
	 */
	protected $authManager;

	public function __construct(AuthManager $authManager)
	{
		$this->authManager = $authManager;
	}

	/**
	 * Verify an email address.
	 *
	 * @param Request $request
	 * @return \Illuminate\Http\RedirectResponse
	 */
	public function getVerify(Request $request)
	{
		$success = $this->authManager->verify($request->token);

		if ( ! $success) {
			return view('errors.bad-verification-link');
		}

		successMessage(trans('auth.verify.success'));
		return redirect()->route('home');
	}
}
