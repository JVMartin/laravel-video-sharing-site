<?php

namespace App\Http\Controllers\Video;

use Illuminate\Http\JsonResponse;
use App\Http\Controllers\Controller;
use App\Repositories\CommentRepository;

class CommentController extends Controller
{
	/**
	 * @var CommentRepository
	 */
	protected $commentRepository;

	public function __construct(CommentRepository $commentRepository)
	{
		$this->commentRepository = $commentRepository;
	}

	public function getCommentsForSubmission($hashId)
	{
		$comments = $this->commentRepository->getBySubmissionId(decodeHash($hashId));
		return new JsonResponse($comments);
	}

	public function postCommentOnSubmission($hashId)
	{
	}
}
