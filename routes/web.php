<?php

Route::get('/', [
	'as' => 'home',
	'uses' => 'Video\BrowseController@getHome'
]);

Route::get('t', function() {
	errorMessage(['test']);
	return redirect()->route('home');
});

Route::get('browse/by-tag/{slug}', [
	'as' => 'browse.by-tag',
	'uses' => 'NoController@getView'
]);

Route::group(['prefix' => 'video'], function() {
	Route::get('{slug}', [
		'as' => 'video.view',
		'uses' => 'Video\ViewController@getView'
	]);
});

Route::group(['prefix' => 'user'], function() {
	Route::get('{username}', [
		'as' => 'user.profile',
		'uses' => 'User\ProfileController@getProfile'
	]);
});

Route::group(['prefix' => 'submit'], function() {
	Route::get('url', [
		'as' => 'video.submit.url',
		'uses' => 'Video\SubmitController@getSubmitUrl'
	]);
	Route::post('url', [
		'as' => 'video.submit.url.process',
		'uses' => 'Video\SubmitController@postSubmitUrl'
	]);
	Route::get('details/{hashId}', [
		'as' => 'video.submit.details',
		'uses' => 'Video\SubmitController@getSubmitDetails'
	]);
	Route::post('details/{hashId}', [
		'as' => 'video.submit.details.process',
		'uses' => 'Video\SubmitController@postSubmitDetails'
	]);
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
	Route::get('picture', [
		'as' => 'account.picture',
		'uses' => 'AccountController@getPicture'
	]);
	Route::post('picture', [
		'as' => 'account.picture.process',
		'uses' => 'AccountController@postPicture'
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
	Route::get('forgot-password/{hashid}/{token}', [
		'as' => 'forgot-password.link',
		'uses' => 'ResetPasswordController@getReset'
	]);
});
