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
	 * @param string $slugHashid
	 * @return Submission|Model|null
	 */
	public function getFromSlugHashid($slugHashid)
	{
		$parts = explode('-', $slugHashid);

		if ( ! count($parts)) {
			return null;
		}

		$hashid = end($parts);
		return $this->submissionRepository->getByHashId($hashid);
	}

	/**
	 * @param Submission $submission
	 */
	public function markUserVote(Submission $submission)
	{

	}
}
