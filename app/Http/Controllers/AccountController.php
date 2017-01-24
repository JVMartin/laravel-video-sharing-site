<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;

class AccountController extends Controller
{
	public function __construct()
	{
		$this->middleware('auth');
	}

	public function getBasics()
	{
		return view('account.basics');
	}

	public function postBasics(Request $request)
	{
		$this->validate($request, [
			'username' => 'required|min:3|alpha_dash|unique:users,username,' . Auth::user()->id
		]);

		successMessage('Your account has been updated.');
		return redirect()->route('account.basics');
	}

	public function getPassword()
	{
		return view('account.password');
	}
}