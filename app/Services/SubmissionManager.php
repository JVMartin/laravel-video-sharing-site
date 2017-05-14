<?php

namespace App\Services;

use Auth;
use App\Models\Submission;
use Illuminate\Database\Eloquent\Model;
use App\Repositories\SubmissionRepository;

class SubmissionManager
{
	/**
	 * @var SubmissionRepository
	 */
	protected $submissionRepository;

	public function __construct(SubmissionRepository $submissionRepository)
	{
		$this->submissionRepository = $submissionRepository;
	}

	/**
	 * Resolve a slug-hashid into a submission.
	 *
	 * @param string $slugHashid
	 * @return Submission|Model|null
	 */
	public function getFromSlugHashid($slugHashid)
	{
		$parts = explode('-', $slugHashid);

		if ( ! count($parts)) {
			return null;
		}

		$hashid = end($parts);
		return $this->submissionRepository->getByHashId($hashid);
	}

	/**
	 * Mark a submission with the signed-in user's vote (if the user is signed-in).
	 *
	 * @param Submission $submission
	 * @return void
	 */
	public function markUserVote(Submission $submission)
	{
		if ( ! Auth::check()) {
			return;
		}

		$submissionVote = $submission->votes()->where('user_id', Auth::user()->id)->first();

		if ( ! $submissionVote) {
			return;
		}

		if ($submissionVote->up) {
			$submission->setUserUp();
		}
		else {
			$submission->setUserDown();
		}
	}
}
