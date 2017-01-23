<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\SendsPasswordResetEmails;

class ForgotPasswordController extends Controller
{
	/*
	|--------------------------------------------------------------------------
	| Password Reset Controller
	|--------------------------------------------------------------------------
	|
	| This controller is responsible for handling password reset emails and
	| includes a trait which assists in sending these notifications from
	| your application to your users. Feel free to explore this trait.
	|
	*/

	use SendsPasswordResetEmails;

	public function __construct()
	{
		$this->middleware('guest');
	}

	public function postForgotPassword(Request $request)
	{
		$this->validate($request, ['email' => 'required|email']);

		return new JsonResponse(trans('auth.forgot-pass'));
	}
}
