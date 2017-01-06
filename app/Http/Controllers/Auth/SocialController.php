<?php

namespace App\Http\Controllers\Auth;

use Socialite;
use Google_Client;
use Google_Service_Oauth2;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class SocialController extends Controller
{
	public function getSignInFacebook()
	{
		return Socialite::driver('facebook')->redirect();
	}

	public function getSignInGoogle()
	{
		return redirect($this->googleClient()->createAuthUrl());
	}

	public function getCallbackFacebook()
	{
		$user = Socialite::driver('facebook')->user();

		dd($user);
	}

	public function getCallbackGoogle(Request $request)
	{
		$this->googleClient()->authenticate($request->code);
		$googleAuth = new Google_Service_Oauth2($this->googleClient());
		$user = $googleAuth->userinfo->get();

		dd($user);
	}

	/**
	 * @return Google_Client
	 */
	private function googleClient()
	{
		static $google = null;
		if ($google === null) {
			$google = new Google_Client();
			$google->setClientId(env('GOOGLE_CLIENT_ID'));
			$google->setClientSecret(env('GOOGLE_CLIENT_SECRET'));
			$google->setRedirectUri(env('GOOGLE_REDIRECT'));
			$google->setScopes(['email', 'profile']);
		}
		return $google;
	}
}