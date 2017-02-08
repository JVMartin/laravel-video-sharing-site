<?php

namespace App\Services;

use App\Models\Submission;
use Illuminate\Database\Eloquent\Model;
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

	/**
	 * @param $slug
	 * @return Submission|Model|null
	 */
	public function getFromSlug($slug)
	{
		$parts = explode('-', $slug);

		if ( ! count($parts)) {
			return null;
		}

		$hashid = end($parts);
		return $this->submissionRepository->getByHashId($hashid);
	}
}
