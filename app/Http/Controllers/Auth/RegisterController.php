<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Http\Request;
use App\Services\AuthManager;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\MessageBag;
use App\Http\Controllers\Controller;

class RegisterController extends Controller
{
	/**
	 * @var AuthManager
	 */
	protected $authManager;

	public function __construct(AuthManager $authManager)
	{
		$this->middleware('guest');

		$this->authManager = $authManager;
	}

	public function postRegister(Request $request)
	{
		$this->validate($request, [
			'email' => 'required|max:255|unique:users',
			'password' => 'required|min:6'
		], [
			'email.unique' => 'There is already an account associated with that email.'
		]);

		$this->authManager->register($request->only('email', 'password'));

		session()->flash('successes', new MessageBag([trans('auth.register')]));
		return new JsonResponse('refresh');
	}
}
