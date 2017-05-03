<?php

namespace App\Services;

use Auth;
use RuntimeException;
use App\Repositories\CommentRepository;
use App\Repositories\SubmissionRepository;

class CommentManager
{
	/**
	 * @var CommentRepository
	 */
	protected $commentRepository;

	/**
	 * @var SubmissionRepository
	 */
	protected $submissionRepository;

	public function __construct(
		CommentRepository $commentRepository,
		SubmissionRepository $submissionRepository
	)
	{
		$this->commentRepository = $commentRepository;
		$this->submissionRepository = $submissionRepository;
	}

	/**
	 * @param string $hashid The hashid of the submission.
	 * @param string $contents The comment contents.
	 * @return string|true
	 */
	public function postCommentOnSubmission($hashid, $contents)
	{
		$submission = $this->submissionRepository->getByHashId($hashid);
		if ( ! $submission) {
			throw new RuntimeException('Comment posted on nonexistent submission ' . $submission);
		}

		$submission->comments()->create([
			'user_id' => Auth::user()->id,
			'parent_id' => null,
			'contents' => $contents,
		]);
	}
}
