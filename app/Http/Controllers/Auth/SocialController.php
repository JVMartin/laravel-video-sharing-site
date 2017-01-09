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

	public function getSignInFacebook()
	{
		return $this->authManager->redirectFacebook();
	}

	public function getSignInGoogle()
	{
		return $this->authManager->redirectGoogle();
	}

	public function getCallbackFacebook()
	{
		$this->authManager->callbackFacebook();
	}

	public function getCallbackGoogle(Request $request)
	{
		$user = $this->authManager->callbackGoogle($request->code);
		$this->guard()->login($user);

		return redirect()
			->intended(route('home'))
			->with('successes', new MessageBag(['You have signed in successfully.']));
	}

}