<?php

namespace App\Http\Controllers\Video;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\RequestValidators\Video\SubmissionValidator;

class SubmitController extends Controller
{
	/**
	 * @var SubmissionValidator
	 */
	protected $submissionValidator;

	public function __construct(SubmissionValidator $submissionValidator)
	{
		$this->middleware('auth');

		$this->submissionValidator = $submissionValidator;
	}

	public function getSubmit()
	{
		return view('video.submit');
	}

	public function postSubmit(Request $request)
	{
		$this->submissionValidator->validateRequest($request);
	}
}
