<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;

class PageController extends Controller
{
	public function getHome()
	{
		return view('pages.home');
	}
}