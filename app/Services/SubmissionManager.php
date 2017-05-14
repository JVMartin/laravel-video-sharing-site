<?php

namespace App\Services;

use Auth;
use App\Models\Submission;
use InvalidArgumentException;
use App\Models\SubmissionVote;
use App\Jobs\CompileSubmission;
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

	/**
	 * Vote on a submission.
	 *
	 * @param string $hashid The hashid of the comment being voted on.
	 * @param int    $value
	 * @return string|true
	 */
	public function vote($hashid, $value)
	{
		$value = (int) $value;

		if ( ! in_array($value, [-1, 1])) {
			throw new InvalidArgumentException('Comment vote not -1 or 1.');
		}

		// Get the comment being voted on.
		$submission = $this->submissionRepository->getByHashId($hashid);
		if ( ! $submission) {
			return 'The submission you are voting on has been deleted.';
		}

		// Get the vote if it exists.
		$submissionVote = SubmissionVote::where('submission_id', $submission->id)
			->where('user_id', Auth::user()->id)
			->first();

		// Create it otherwise.
		if ( ! $submissionVote) {
			$submissionVote = new SubmissionVote();
		}

		// Update / insert it.
		$submissionVote->submission_id = $submission->id;
		$submissionVote->user_id = Auth::user()->id;
		$submissionVote->up = ($value == 1) ? 1 : 0;
		$submissionVote->down = ($value == -1) ? 1 : 0;
		$submissionVote->save();

		// Ensure the comment's vote numbers get recompiled.
		dispatch(new CompileSubmission($submission));

		return true;
	}
}
