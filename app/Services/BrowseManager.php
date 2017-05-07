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

	protected function browseQuery()
	{
		return Submission::with('commentsCount')->orderBy('created_at', 'DESC');
	}

	public function home()
	{
		return $this->browseQuery()->paginate(16);
	}

	public function user($id)
	{
		return $this->browseQuery()->where('user_id', $id)->paginate(16);
	}
}
