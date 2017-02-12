<?php

namespace App\Services;

use App\Models\Submission;
use App\Repositories\VideoRepository;
use App\Repositories\SubmissionRepository;

class BrowseManager
{
	/**
	 * @var VideoRepository
	 */
	protected $videoRepository;

	/**
	 * @var SubmissionRepository
	 */
	protected $submissionRepository;

	public function __construct(
		VideoRepository $videoRepository,
		SubmissionRepository $submissionRepository
	)
	{
		$this->videoRepository = $videoRepository;
		$this->submissionRepository = $submissionRepository;
	}

	public function home()
	{
		return Submission::orderBy('created_at', 'DESC')->paginate(16);
	}
}
