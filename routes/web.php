<?php

Route::get('/', [
	'as' => 'home',
	'uses' => 'PageController@getHome'
]);

Route::get('t', function() {
	successMessage(['a', 'b', 'c']);
	errorMessage(['a', 'b']);
	return redirect()->route('home');
});

Route::group(['prefix' => 'account'], function() {
	Route::get('basics', [
		'as' => 'account.basics',
		'uses' => 'AccountController@getBasics'
	]);
	Route::post('basics', [
		'as' => 'account.basics.process',
		'uses' => 'AccountController@postBasics'
	]);
	Route::get('resend-verification', [
		'as' => 'account.resend-verification',
		'uses' => 'AccountController@getResendVerification'
	]);
	Route::get('password', [
		'as' => 'account.password',
		'uses' => 'AccountController@getPassword'
	]);
	Route::post('password', [
		'as' => 'account.password.process',
		'uses' => 'AccountController@postPassword'
	]);
});

Route::group(['namespace' => 'Auth'], function() {
	Route::get('sign-in/facebook', [
		'as' => 'sign-in.social.facebook',
		'uses' => 'SocialController@getSignInFacebook'
	]);
	Route::get('sign-in/google', [
		'as' => 'sign-in.social.google',
		'uses' => 'SocialController@getSignInGoogle'
	]);
	Route::get('sign-in/callback/facebook', [
		'as' => 'sign-in.social.facebook.callback',
		'uses' => 'SocialController@getCallbackFacebook'
	]);
	Route::get('sign-in/callback/google', [
		'as' => 'sign-in.social.google.callback',
		'uses' => 'SocialController@getCallbackGoogle'
	]);

	Route::post('sign-in', [
		'as' => 'sign-in.email',
		'uses' => 'SignInController@postSignIn'
	]);

	Route::get('sign-out', [
		'as' => 'sign-out',
		'uses' => 'SignInController@getSignOut'
	]);

	Route::post('register', [
		'as' => 'register',
		'uses' => 'RegisterController@postRegister'
	]);

	Route::get('verify/{token}', [
		'as' => 'verify',
		'uses' => 'VerificationController@getVerify'
	]);

	Route::post('forgot-password', [
		'as' => 'forgot-password',
		'uses' => 'ForgotPasswordController@postForgotPassword'
	]);
	Route::get('forgot-password/{token}', [
		'as' => 'forgot-password.link',
		'uses' => 'ResetPasswordController@getReset'
	]);
});