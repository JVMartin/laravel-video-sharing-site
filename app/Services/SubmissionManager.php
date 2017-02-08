<?php

namespace App\Services;

use App\Repositories\SubmissionRepository;

class SubmissionManager
{
	/**
	 * @var SubmissionRepository
	 */
	protected $submissionRepository;

	public function __construct(SubmissionRepository $submissionRepository)
	{
		$this->submissionRepository = $submissionRepository;
	}

	public function getFromSlug($slug)
	{

	}
}
