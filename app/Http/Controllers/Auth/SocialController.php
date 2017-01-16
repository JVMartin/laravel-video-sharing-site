<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Http\Request;
use App\Services\AuthManager;
use Illuminate\Support\MessageBag;
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
		return $this->authManager->redirectFacebook();
	}

	/**
	 * @return \Illuminate\Http\RedirectResponse
	 */
	public function getSignInGoogle()
	{
		return $this->authManager->redirectGoogle();
	}

	/**
	 * @param Request $request
	 * @return \Illuminate\Http\RedirectResponse
	 */
	public function getCallbackFacebook(Request $request)
	{
		$this->authManager->callbackFacebook();
	}

	/**
	 * @param Request $request
	 * @return \Illuminate\Http\RedirectResponse
	 */
	public function getCallbackGoogle(Request $request)
	{
		$user = $this->authManager->callbackGoogle($request->code);
		$this->guard()->login($user);

		return redirect()
			->intended(route('home'))
			->with('successes', new MessageBag([trans('auth.sign-in.success')]));
	}

}