<?php

namespace App\Http\Controllers\Video;

use App\Models\Submission;
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
	 * @param string $slugHashid
	 * @return \Illuminate\View\View
	 */
	public function getView($slugHashid)
	{
		$submission = $this->submissionManager->getFromSlugHashid($slugHashid);

		if ( ! $submission instanceof Submission) {
			abort(404);
		}

		// Redirect them to the correct URL if their slug doesn't match.
		if ($slugHashid != $submission->slugHashid()) {
			return redirect($submission->url());
		}

		$this->submissionManager->markUserVote($submission);

		return view('video.view', [
			'submission' => $submission
		]);
	}
}
