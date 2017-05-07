<?php

namespace App\Services;

use App\Models\User;
use App\Models\Submission;
use App\Repositories\VideoRepository;
use App\Repositories\SubmissionRepository;

class BrowseManager
{
	const PER_PAGE = 16;

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

	/**
	 * @return \Illuminate\Database\Eloquent\Builder
	 */
	protected function browseQuery()
	{
		return Submission::with('commentsCount')->orderBy('created_at', 'DESC');
	}

	/**
	 * @return \Illuminate\Contracts\Pagination\LengthAwarePaginator
	 */
	public function home()
	{
		return $this->browseQuery()->paginate(static::PER_PAGE);
	}

	/**
	 * @param User $user
	 * @return \Illuminate\Contracts\Pagination\LengthAwarePaginator
	 */
	public function user($user)
	{
		return $this->browseQuery()->where('user_id', $user->id)->paginate(static::PER_PAGE);
	}
}
