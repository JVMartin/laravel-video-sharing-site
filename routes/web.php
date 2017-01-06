<?php

Route::get('/', 'PageController@getHome');

Route::group(['namespace' => 'Auth'], function() {

	Route::get('sign-in/facebook', [
		'as' => 'sign-in.social.facebook',
		'uses' => 'SocialController@getSignInFacebook'
	]);
	Route::get('sign-in/google', [
		'as' => 'sign-in.social.google',
		'uses' => 'SocialController@getSignInGoogle'
	]);

	Route::group(['namespace' => 'Auth'], function() {
		Route::get('/sign-out', 'LoginController@logout');
	});

	// MUST be the last route defined, as it has a base-level, catch-all variable.
	Route::get('{slug}', 'PageController@getPage');
});