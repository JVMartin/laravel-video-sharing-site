<?php

namespace App\Http\Controllers\Video;

use App\Models\Submission;
use App\Services\SubmissionManager;
use App\Http\Controllers\Controller;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

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
		$submission = $this->submissionManager->getFromSlug($slug);

		if ( ! $submission instanceof Submission) {
			throw new NotFoundHttpException;
		}

		return view('video.submit.get-url');
	}
}
