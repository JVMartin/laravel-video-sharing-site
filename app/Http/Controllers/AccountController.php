<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use App\Services\AuthManager;
use App\Repositories\UserRepository;
use App\Events\EmailRequiresVerification;
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

	/**
	 * @var AuthManager
	 */
	protected $authManager;

	public function __construct(
		UserRepository $userRepository,
		VerificationRepository $verificationRepository,
		AuthManager $authManager
	)
	{
		$this->middleware('auth');
		$this->middleware('non-social', [
			'only' => ['getResendVerification', 'getPassword', 'postPassword']
		]);

		$this->userRepository = $userRepository;
		$this->verificationRepository = $verificationRepository;
		$this->authManager = $authManager;
	}

	/**
	 * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
	 */
	public function getBasics()
	{
		$data = [];

		if ( ! Auth::user()->usesSocialAuthentication()) {
			$verification = $this->verificationRepository->get(Auth::user()->id);
			$data['verified'] = ($verification) ? false : true;
			if ($verification) {
				$data['daysUntilDeletion'] = $this->verificationRepository->daysUntilDeletion($verification);
			}
		}

		return view('account.basics', $data);
	}

	/**
	 * @return \Illuminate\Http\RedirectResponse
	 */
	public function getResendVerification()
	{
		event(new EmailRequiresVerification(Auth::user()));
		successMessage('Verification email resent.');
		return redirect()->route('account.basics');
	}

	/**
	 * @param Request $request
	 * @return \Illuminate\Http\RedirectResponse
	 */
	public function postBasics(Request $request)
	{
		$user = Auth::user();

		$rules = [
			'username' => 'required|alpha_dash|min:3|max:40|unique:users,username,' . $user->id,
			'first_name' => 'max:255',
			'last_name' => 'max:255'
		];
		if ( ! $user->usesSocialAuthentication()) {
			$rules['email'] = 'required|email|max:255|unique:users,email,' . $user->id;
		}
		$this->validate($request, $rules);

		$inputs = ['username', 'first_name', 'last_name'];
		if ( ! $user->usesSocialAuthentication()) {
			$inputs []= 'email';
		}
		$this->userRepository->update($user, $request->only($inputs));

		successMessage('Your account has been updated.');
		return redirect()->route('account.basics');
	}

	/**
	 * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
	 */
	public function getPassword()
	{
		return view('account.password');
	}

	public function postPassword(Request $request)
	{
		$this->validate($request, [
			'password' => 'required|confirmed|min:6'
		]);

		$this->userRepository->update(Auth::user(), $request->only('password'));
		successMessage('Your password has been changed.');
		return redirect()->route('account.password');
	}
}