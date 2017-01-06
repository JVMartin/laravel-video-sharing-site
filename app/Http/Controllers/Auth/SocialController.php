<?php

namespace App\Http\Controllers\Auth;

use Socialite;
use App\Http\Controllers\Controller;

class SocialController extends Controller
{
	public function getSignInFacebook()
	{
		return Socialite::driver('facebook')->redirect();
	}

	public function getSignInGoogle()
	{
		return Socialite::driver('google')->redirect();
	}

	public function getCallbackFacebook()
	{
		$user = Socialite::driver('facebook')->user();

		dd($user);
	}

	public function getCallbackGoogle()
	{
		$user = Socialite::driver('google')->user();

		dd($user);
	}
}