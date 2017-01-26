<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\SendsPasswordResetEmails;

class ForgotPasswordController extends Controller
{
	use SendsPasswordResetEmails;

	public function __construct()
	{
		$this->middleware('guest');
	}

	/**
	 * @param Request $request
	 * @return JsonResponse
	 */
	public function postForgotPassword(Request $request)
	{
		$this->validate($request, ['email' => 'required|email']);

		$this->broker()->sendResetLink($request->only('email'));

		return new JsonResponse(trans('auth.forgot-pass'));
	}
}
