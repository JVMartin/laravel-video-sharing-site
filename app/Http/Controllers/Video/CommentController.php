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

		$this->middleware('auth', [
			'only' => ['postCommentOnSubmission', 'postVote']
		]);
	}

	/**
	 * @param string $hashid
	 * @param string $parent_hashid
	 * @return JsonResponse
	 */
	public function getCommentsForSubmission($hashid, $parent_hashid = null)
	{
		$comments = $this->commentRepository->getComments(decodeHash($hashid), decodeHash($parent_hashid));
		return new JsonResponse($comments);
	}

	/**
	 * @param Request $request
	 * @param string  $parent_hashid
	 * @return JsonResponse
	 */
	public function postCommentOnSubmission(Request $request, $hashid, $parent_hashid = null)
	{
		$comment = $this->commentManager->postCommentOnSubmission($request->comment, $hashid, decodeHash($parent_hashid));

		if ( ! $comment instanceof Comment) {
			return new JsonResponse($comment, 422);
		}

		return new JsonResponse($comment);
	}

	/**
	 * @param Request $request
	 * @param string  $hashid
	 * @return JsonResponse
	 */
	public function postVote(Request $request, $hashid)
	{
		$comment = $this->commentManager->vote($hashid, $request->value);

		if ( ! $comment instanceof Comment) {
			return new JsonResponse($comment, 422);
		}

		return new JsonResponse($comment);
	}
}
