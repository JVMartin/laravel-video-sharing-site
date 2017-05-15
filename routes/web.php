<?php

Route::get('/', [
	'as' => 'home',
	'uses' => 'Video\BrowseController@getHome',
]);

Route::get('feed', [
	'as' => 'feed',
	'uses' => 'Video\BrowseController@getMyFeed',
]);

Route::get('browse/by-tag/{slug}', [
	'as' => 'browse.by-tag',
	'uses' => 'Video\BrowseController@getByTag',
]);

Route::group(['prefix' => 'video'], function() {
	Route::get('{slug}', [
		'as' => 'video.view',
		'uses' => 'Video\ViewController@getView',
	]);
});

Route::group(['prefix' => 'notifications'], function() {
	Route::get('/', [
		'as' => 'notifications',
		'uses' => 'User\NotificationController@getNotifications',
	]);
	Route::post('read/{hashid}', [
		'as' => 'notifications.read',
		'uses' => 'User\NotificationController@postReadNotification',
	]);
	Route::get('read-all', [
		'as' => 'notifications.read-all',
		'uses' => 'User\NotificationController@getReadAllNotifications',
	]);
});

Route::group(['prefix' => 'submissions'], function() {
	Route::post('vote/{hashid}', [
		'as' => 'submissions.vote',
		'uses' => 'Video\SubmissionController@postVote',
	]);
});

Route::group(['prefix' => 'comments'], function() {
	Route::get('submission/{hashid}/{parent_hashid?}', [
		'as' => 'comments.submission',
		'uses' => 'Video\CommentController@getComments',
	]);
	Route::post('submission/{hashid}/{parent_hashid?}', [
		'as' => 'comments.submission.post',
		'uses' => 'Video\CommentController@postComment',
	]);
	Route::post('vote/{hashid}', [
		'as' => 'comments.vote',
		'uses' => 'Video\CommentController@postVote',
	]);
});

Route::group(['prefix' => 'users'], function() {
	Route::post('follow/{hashid}', [
		'as' => 'user.follow',
		'uses' => 'User\FollowController@postFollow',
	]);
});

Route::group(['prefix' => 'user'], function() {
	Route::get('{username}', [
		'as' => 'user.profile',
		'uses' => 'User\ProfileController@getIndex',
	]);
	Route::get('{username}/submissions', [
		'as' => 'user.profile.submissions',
		'uses' => 'User\ProfileController@getSubmissions',
	]);
	Route::get('{username}/comments', [
		'as' => 'user.profile.comments',
		'uses' => 'User\ProfileController@getComments',
	]);
});

Route::group(['prefix' => 'submit'], function() {
	Route::get('url', [
		'as' => 'video.submit.url',
		'uses' => 'Video\SubmitController@getSubmitUrl',
	]);
	Route::post('url', [
		'as' => 'video.submit.url.process',
		'uses' => 'Video\SubmitController@postSubmitUrl',
	]);
	Route::get('details/{hashid}', [
		'as' => 'video.submit.details',
		'uses' => 'Video\SubmitController@getSubmitDetails',
	]);
	Route::post('details/{hashid}', [
		'as' => 'video.submit.details.process',
		'uses' => 'Video\SubmitController@postSubmitDetails',
	]);
});

Route::group(['prefix' => 'account'], function() {
	Route::get('basics', [
		'as' => 'account.basics',
		'uses' => 'AccountController@getBasics',
	]);
	Route::post('basics', [
		'as' => 'account.basics.process',
		'uses' => 'AccountController@postBasics',
	]);
	Route::get('picture', [
		'as' => 'account.picture',
		'uses' => 'AccountController@getPicture',
	]);
	Route::get('picture/delete', [
		'as' => 'account.picture.delete',
		'uses' => 'AccountController@getDeletePicture',
	]);
	Route::post('picture', [
		'as' => 'account.picture.process',
		'uses' => 'AccountController@postPicture',
	]);
	Route::get('resend-verification', [
		'as' => 'account.resend-verification',
		'uses' => 'AccountController@getResendVerification',
	]);
	Route::get('password', [
		'as' => 'account.password',
		'uses' => 'AccountController@getPassword',
	]);
	Route::post('password', [
		'as' => 'account.password.process',
		'uses' => 'AccountController@postPassword',
	]);
});

Route::group(['namespace' => 'Auth'], function() {
	Route::get('sign-in/facebook', [
		'as' => 'sign-in.social.facebook',
		'uses' => 'SocialController@getSignInFacebook',
	]);
	Route::get('sign-in/google', [
		'as' => 'sign-in.social.google',
		'uses' => 'SocialController@getSignInGoogle',
	]);
	Route::get('sign-in/callback/facebook', [
		'as' => 'sign-in.social.facebook.callback',
		'uses' => 'SocialController@getCallbackFacebook',
	]);
	Route::get('sign-in/callback/google', [
		'as' => 'sign-in.social.google.callback',
		'uses' => 'SocialController@getCallbackGoogle',
	]);

	Route::post('sign-in', [
		'as' => 'sign-in.email',
		'uses' => 'SignInController@postSignIn',
	]);

	Route::get('sign-out', [
		'as' => 'sign-out',
		'uses' => 'SignInController@getSignOut',
	]);

	Route::post('register', [
		'as' => 'register',
		'uses' => 'RegisterController@postRegister',
	]);

	Route::get('verify/{token}', [
		'as' => 'verify',
		'uses' => 'VerificationController@getVerify',
	]);

	Route::post('forgot-password', [
		'as' => 'forgot-password',
		'uses' => 'ForgotPasswordController@postForgotPassword',
	]);
	Route::get('forgot-password/{hashid}/{token}', [
		'as' => 'forgot-password.link',
		'uses' => 'ResetPasswordController@getReset',
	]);
});
