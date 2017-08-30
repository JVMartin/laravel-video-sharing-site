<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Http\Request;
use App\Services\AuthManager;
use Illuminate\Http\JsonResponse;
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
			'only' => ['postSignIn'],
		]);
		$this->middleware('guest', [
			'only' => ['postSignIn'],
		]);
		$this->middleware('auth', [
			'only' => ['getSignOut'],
		]);

		$this->authManager = $authManager;
	}

	/**
	 * @param Request $request
	 * @return JsonResponse
	 */
	public function postSignIn(Request $request)
	{
		$this->validate($request, [
			'email' => 'required',
			'password' => 'required',
		]);

		$success = $this->authManager->signIn($request->only([
			'email',
			'password',
		]), $request->has('remember'));

		if ( ! $success) {
			return new JsonResponse([trans('auth.sign-in.failure')], 422);
		}

		successMessage(trans('auth.sign-in.success'));
		return new JsonResponse('refresh');
	}

	/**
	 * Sign the user out of the application.
	 *
	 * @return \Illuminate\Http\RedirectResponse
	 */
	public function getSignOut()
	{
		$this->authManager->signOut();

		successMessage(trans('auth.sign-out'));
		return redirect()->back();
	}
}
