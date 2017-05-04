<?php

namespace App\Http\Controllers\Video;

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
	 * @return JsonResponse
	 */
	public function getCommentsForSubmission($hashid)
	{
		$comments = $this->commentRepository->getBySubmissionId(decodeHash($hashid));
		return new JsonResponse($comments);
	}

	/**
	 * @param Request $request
	 * @param string $hashid
	 * @return JsonResponse
	 */
	public function postCommentOnSubmission(Request $request, $hashid)
	{
		$comment = $this->commentManager->postCommentOnSubmission($hashid, $request->comment);

		return new JsonResponse($comment);
	}
}
