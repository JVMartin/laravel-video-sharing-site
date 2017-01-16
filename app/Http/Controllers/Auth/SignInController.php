<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Http\Request;
use App\Services\AuthManager;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\MessageBag;
use App\Http\Controllers\Controller;

class SignInController extends Controller
{
	/**
	 * @var AuthManager
	 */
	protected $authManager;

	public function __construct(AuthManager $authManager)
	{
		$this->middleware('throttle:10,10', [
			'only' => ['postSignIn']
		]);

		$this->authManager = $authManager;
	}

	/**
	 * @param Request $request
	 */
	public function postSignIn(Request $request)
	{
		return new JsonResponse(['test'], 422);
//		$this->validate($request, [
//			'email' => 'required',
//			'password' => 'required'
//		]);

//		$success = $this->authManager->signIn($request->only([
//			'email',
//			'password'
//		]), $request->has('remember'));

//		if ($success) {
//			return redirect()->route('home')
//				->with('successes', new MessageBag([AuthManager::SIGN_IN_SUCCESS]);
//		}
//		else {
//			return new JsonResponse($errors, 422);
//		}
	}

	/**
	 * Sign the user out of the application.
	 *
	 * @return \Illuminate\Routing\Redirector|\Illuminate\Http\RedirectResponse
	 */
	public function getSignOut()
	{
		$this->authManager->signOut();

		return redirect('/')
			->with('successes', new MessageBag(['You have signed out.  Come back soon!']));
	}
}
