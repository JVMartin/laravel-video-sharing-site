<?php

namespace App\Http\Controllers\Video;

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

	public function getCommentsForSubmission($slug)
	{
	}

	public function postCommentOnSubmission($slug)
	{
	}
}
