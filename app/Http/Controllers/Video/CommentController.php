<?php

namespace App\Http\Controllers\Video;

use App\Models\Comment;
use Illuminate\Http\Request;
use App\Services\CommentManager;
use Illuminate\Http\JsonResponse;
use App\Http\Controllers\Controller;
use App\Repositories\CommentRepository;

class CommentController extends Controller
{
	/**
	 * @var CommentRepository
	 */
	protected $commentRepository;

	/**
	 * @var CommentManager
	 */
	protected $commentManager;

	public function __construct(
		CommentRepository $commentRepository,
		CommentManager $commentManager
	)
	{
		$this->commentRepository = $commentRepository;
		$this->commentManager = $commentManager;
	}

	/**
	 * @param string $hashid
	 * @param string $parent_hash
	 * @return JsonResponse
	 */
	public function getCommentsForSubmission($hashid, $parent_hash = null)
	{
		$comments = $this->commentRepository->getBySubmissionId(decodeHash($hashid), $parent_hash);
		return new JsonResponse($comments);
	}

	/**
	 * @param Request $request
	 * @param string $parent_hash
	 * @return JsonResponse
	 */
	public function postCommentOnSubmission(Request $request, $hashid, $parent_hash = null)
	{
		$comment = $this->commentManager->postCommentOnSubmission($request->comment, $hashid, decodeHash($parent_hash));

		if ( ! $comment instanceof Comment) {
			return new JsonResponse($comment, 422);
		}

		return new JsonResponse($comment);
	}
}
