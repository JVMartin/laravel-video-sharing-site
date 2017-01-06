<?php

namespace App\Http\Controllers;

class PageController extends Controller
{
	public function getHome()
	{
		return view('pages.home');
	}
}