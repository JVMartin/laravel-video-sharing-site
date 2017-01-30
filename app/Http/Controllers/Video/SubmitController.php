<?php

namespace App\Http\Controllers\Video;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class SubmitController extends Controller
{
	public function __construct()
	{
		$this->middleware('auth');
	}

	public function getSubmit(Request $request)
	{
		$code = $request->v;

		if ( ! strlen($code)) {
			return view('video.submit.get-code');
		}
	}

	public function postSubmit(Request $request)
	{
	}
}
