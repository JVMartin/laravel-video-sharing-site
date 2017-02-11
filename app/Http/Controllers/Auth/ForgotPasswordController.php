<?php

namespace App\Http\Controllers\Auth;

use Mail;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Mail\ResetPasswordSocialEmail;
use App\Repositories\UserRepository;
use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\SendsPasswordResetEmails;

class ForgotPasswordController extends Controller
{
	use SendsPasswordResetEmails;

	/**
	 * @var UserRepository
	 */
	protected $userRepository;

	public function __construct(UserRepository $userRepository)
	{
		$this->middleware('guest');

		$this->userRepository = $userRepository;
	}

	/**
	 * @param Request $request
	 * @return JsonResponse
	 */
	public function postForgotPassword(Request $request)
	{
		$this->validate($request, ['email' => 'required|email']);

		$user = $this->userRepository->getByEmail($request->email);
		if ($user) {
			if ($user->usesSocialAuthentication()) {
				Mail::to($user->email)
					->send(new ResetPasswordSocialEmail);
			}
			else {
				$this->broker()->sendResetLink($request->only('email'));
			}
		}

		return new JsonResponse(trans('auth.forgot-pass.email-sent'));
	}
}
