<?php

namespace App\Http\Controllers\Video;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class SubmitController extends Controller
{
    public function getSubmit()
    {
		return view('video.submit');
    }

    public function postSubmit()
    {

    }
}
