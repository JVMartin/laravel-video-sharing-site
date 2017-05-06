<?php

namespace App\Services;

use Auth;
use RuntimeException;
use App\Models\Comment;
use App\Models\CommentVote;
use App\Jobs\CompileComment;
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
	 * @param string $contents  The comment contents.
	 * @param string $hashid    The hashid of the submission.
	 * @param string $parent_id The parent_id
	 * @return Comment|string   The successfully posted comment, or an error.
	 */
	public function postComment($contents, $hashid, $parent_id = null)
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
			return 'The comment you are replying to has been deleted.';
		}

		$comment = $submission->comments()->create([
			'user_id' => Auth::user()->id,
			'parent_id' => $parent_id,
			'contents' => $contents,
		]);

		// Automatically updoot our own comment.
		CommentVote::create([
			'comment_id' => $comment->id,
			'user_id' => Auth::user()->id,
			'up' => 1,
		]);

		if ($parent_id) {
			$parentComment = $this->commentRepository->getByKey($parent_id);

			if ( ! $parentComment) {
				throw new RuntimeException('Comment id ' . $comment->id . ' missing parent id ' . $parent_id);
			}

			// Ensure the parent's reply count gets re-compiled.
			dispatch(new CompileComment($parentComment));
		}

		// Ensure the comment has all of its attributes by grabbing it fresh from the database.
		return $this->commentRepository->getByKey($comment->id);
	}

	/**
	 * Vote on a comment.
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
		$comment = $this->commentRepository->getByHashId($hashid);
		if ( ! $comment) {
			return 'The comment you are voting on has been deleted.';
		}

		// Get the vote if it exists.
		$commentVote = CommentVote::where('comment_id', $comment->id)
			->where('user_id', Auth::user()->id)
			->first();

		// Create it otherwise.
		if ( ! $commentVote) {
			$commentVote = new CommentVote;
		}

		// Update / insert it.
		$commentVote->comment_id = $comment->id;
		$commentVote->user_id = Auth::user()->id;
		$commentVote->up = ($value == 1) ? 1 : 0;
		$commentVote->down = ($value == -1) ? 1 : 0;
		$commentVote->save();

		// Ensure the comment's vote numbers get recompiled.
		dispatch(new CompileComment($comment));

		return true;
	}
}
