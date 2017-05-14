<?php

namespace App\Http\Controllers\Video;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Services\SubmissionManager;
use App\Http\Controllers\Controller;

class SubmissionController extends Controller
{
	/**
	 * @var SubmissionManager
	 */
	protected $submissionManager;

	public function __construct(SubmissionManager $submissionManager)
	{
		$this->middleware('auth');

		$this->submissionManager = $submissionManager;
	}

	/**
	 * @param Request $request
	 * @param string  $hashid
	 * @return JsonResponse
	 */
	public function postVote(Request $request, $hashid)
	{
		$submission = $this->submissionManager->vote($hashid, $request->value);

		if ($submission !== true) {
			return new JsonResponse($submission, 422);
		}

		return new JsonResponse();
	}
}
