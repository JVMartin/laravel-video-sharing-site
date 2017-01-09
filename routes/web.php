<?php

Route::get('/', [
	'as' => 'home',
	'uses' => 'PageController@getHome'
]);

Route::get('t', function() {
	return redirect()->route('home')->withErrors('test');
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
});