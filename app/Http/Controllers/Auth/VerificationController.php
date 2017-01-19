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
	 * @param Request $request
	 * @return \Illuminate\Http\RedirectResponse
	 */
	public function getVerify(Request $request)
	{
		$success = $this->authManager->verify($request->token);

		if ( ! $success) {
			return redirect()->route('home')
				->withErrors(trans('auth.verify.failure'));
		}

		successMessage(trans('auth.verify.success'));
		return redirect()->route('home');
	}
}
