<?php

namespace App\Http\Controllers;

class ProfileController extends Controller
{
	public function __construct()
	{
		$this->middleware('auth');
	}

	public function getProfile()
	{
		return 'heyo';
	}
}