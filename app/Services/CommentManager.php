<?php

namespace App\Services;

use Auth;
use RuntimeException;
use App\Models\Comment;
use InvalidArgumentException;
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
	 * @param string $contents The comment contents.
	 * @param string $hashid The hashid of the submission.
	 * @param string $parent_id The parent_id
	 * @return Comment|string The successfully posted comment, or an error.
	 */
	public function postCommentOnSubmission($contents, $hashid, $parent_id = null)
	{
		$submission = $this->submissionRepository->getByHashId($hashid);
		if ( ! $submission) {
			throw new InvalidArgumentException('Comment posted on nonexistent submission hash ' . $hashid);
		}

		if ( ! strlen($contents)) {
		    throw new InvalidArgumentException('Empty comment posted on submission id ' . $submission->id);
        }

        // This is not an exceptional occurence - can happen if replying to a user that deleted their
		// comment.
		if ($parent_id && ! Comment::where('id', $parent_id)->count()) {
			return 'The comment you are replying to has been deleted!';
		}

		$comment = $submission->comments()->create([
			'user_id' => Auth::user()->id,
			'parent_id' => $parent_id,
			'contents' => $contents,
		]);

		if ($parent_id) {
			$parentComment = $this->commentRepository->getByKey($parent_id);

			if ( ! $parentComment) {
				throw new RuntimeException('Comment id ' . $comment->id . ' missing parent id ' . $parent_id);
			}

			$this->commentRepository->updateReplyCount($parentComment);
		}

		// Ensure the comment has all of its attributes by grabbing it fresh from the database.
		return $this->commentRepository->getByKey($comment->id);
	}
}
