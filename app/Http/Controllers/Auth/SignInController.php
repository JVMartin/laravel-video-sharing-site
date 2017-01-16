<?php

namespace App\Http\Controllers\Auth;

use \Illuminate\Http\Request;
use Illuminate\Support\MessageBag;
use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\AuthenticatesUsers;

class SignInController extends Controller
{
	use AuthenticatesUsers;

	public function __construct()
	{
		$this->middleware('throttle:10,10', [
			'only' => ['postSignIn']
		]);
	}

	/**
	 * @param Request $request
	 */
	public function postSignIn(Request $request)
	{
		$this->validate($request, [
			'email' => 'required',
			'password' => 'required'
		]);
	}

	/**
     * Sign the user out of the application.
     *
     * @param Request $request
     * @return \Illuminate\Http\Response
     */
	public function getSignOut(Request $request)
	{
		$this->guard()->logout();

		$request->session()->flush();

		$request->session()->regenerate();

		return redirect('/')
			->with('successes', new MessageBag(['You have signed out.  Come back soon!']));
	}
}
