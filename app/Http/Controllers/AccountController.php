<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use App\Repositories\UserRepository;
use App\Repositories\VerificationRepository;

class AccountController extends Controller
{
	/**
	 * @var UserRepository
	 */
	protected $userRepository;

	/**
	 * @var VerificationRepository
	 */
	protected $verificationRepository;

	public function __construct(UserRepository $userRepository, VerificationRepository $verificationRepository)
	{
		$this->middleware('auth');

		$this->userRepository = $userRepository;
		$this->verificationRepository = $verificationRepository;
	}

	public function getBasics()
	{
		return view('account.basics');
	}

	public function postBasics(Request $request)
	{
		$user = Auth::user();
		$this->validate($request, [
			'username' => 'required|min:3|alpha_dash|unique:users,username,' . $user->id
		]);

		$this->userRepository->update($user, $request->only('username', 'first_name', 'last_name'));

		successMessage('Your account has been updated.');
		return redirect()->route('account.basics');
	}

	public function getPassword()
	{
		return view('account.password');
	}
}