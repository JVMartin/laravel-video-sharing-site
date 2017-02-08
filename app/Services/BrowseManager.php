<?php

namespace App\Services;

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
}
