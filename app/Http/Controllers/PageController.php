<?php

namespace App\Http\Controllers;

class PageController extends Controller
{
	public function getTerms()
	{
		return view('pages.terms');
	}
}