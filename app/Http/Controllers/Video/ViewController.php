<?php

namespace App\Http\Controllers\Video;

use App\Services\SubmissionManager;
use App\Http\Controllers\Controller;

class ViewController extends Controller
{
	/**
	 * @var SubmissionManager
	 */
	protected $submissionManager;

	public function __construct(SubmissionManager $submissionManager)
	{
		$this->submissionManager = $submissionManager;
	}

	/**
	 * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
	 */
	public function getView($slug)
	{
		$video = $this->submissionManager->getFromSlug($slug);
		return view('video.submit.get-url');
	}
}
