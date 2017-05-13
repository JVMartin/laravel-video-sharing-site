<?php

namespace App\Http\Controllers\Auth;

use URL;
use Illuminate\Http\Request;
use App\Services\AuthManager;
use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\AuthenticatesUsers;

class SocialController extends Controller
{
	use AuthenticatesUsers;

	/**
	 * @var AuthManager
	 */
	protected $authManager;

	public function __construct(AuthManager $authManager)
	{
		$this->authManager = $authManager;
	}

	/**
	 * @return \Illuminate\Http\RedirectResponse
	 */
	public function getSignInFacebook()
	{
		session(['url.intended' => URL::previous()]);
		return $this->authManager->redirectFacebook();
	}

	/**
	 * @return \Illuminate\Http\RedirectResponse
	 */
	public function getSignInGoogle()
	{
		session(['url.intended' => URL::previous()]);
		return $this->authManager->redirectGoogle();
	}

	/**
	 * @param Request $request
	 * @return \Illuminate\Http\RedirectResponse
	 */
	public function getCallbackFacebook()
	{
		$user = $this->authManager->callbackFacebook();
	}

	/**
	 * @param Request $request
	 * @return \Illuminate\Http\RedirectResponse
	 */
	public function getCallbackGoogle(Request $request)
	{
		$user = $this->authManager->callbackGoogle($request->code);
		$this->guard()->login($user);

		successMessage(trans('auth.sign-in.success'));
		return redirect()
			->intended(route('home'));
	}

}