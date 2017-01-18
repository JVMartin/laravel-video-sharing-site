<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Http\Request;
use App\Repositories\UserRepository;
use App\Http\Controllers\Controller;
use Illuminate\Auth\Events\Registered;
use Illuminate\Foundation\Auth\RegistersUsers;

class RegisterController extends Controller
{
	use RegistersUsers;

	/**
	 * @var UserRepository
	 */
	protected $userRepository;

	public function __construct(UserRepository $userRepository)
	{
		$this->middleware('guest');

		$this->userRepository = $userRepository;
	}

	public function postRegister(Request $request)
	{
		$this->validate($request, [
			'email' => 'required|max:255|unique:users',
			'password' => 'required|min:6'
		]);

		$user = $this->userRepository->create($request->only('email', 'password'));
		event(new Registered($user));
	}
}
