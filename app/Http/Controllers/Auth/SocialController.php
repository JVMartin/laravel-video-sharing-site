<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Http\Request;
use App\Services\AuthManager;
use App\Http\Controllers\Controller;

class SocialController extends Controller
{
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
		$this->authManager->callbackGoogle($request->code);
	}

}