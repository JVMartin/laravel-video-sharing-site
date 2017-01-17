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
	 * @return JsonResponse
	 */
	public function postSignIn(Request $request)
	{
		$this->validate($request, [
			'email' => 'required',
			'password' => 'required'
		]);

		$success = $this->authManager->signIn($request->only([
			'email',
			'password'
		]), $request->has('remember'));

		if ($success) {
			session()->flash('successes', new MessageBag([trans('auth.sign-in.success')]));
			return new JsonResponse('refresh');
		}
		else {
			return new JsonResponse([trans('auth.sign-in.failure')], 422);
		}
	}

	/**
	 * Sign the user out of the application.
	 *
	 * @return \Illuminate\Http\RedirectResponse
	 */
	public function getSignOut()
	{
		$this->authManager->signOut();

		return redirect(route('home'))
			->with('successes', new MessageBag([trans('auth.sign-out')]));
	}
}
