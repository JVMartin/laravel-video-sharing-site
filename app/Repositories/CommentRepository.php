<?php

namespace App\Repositories;

use App\Models\Comment;
use Illuminate\Cache\Repository;
use Illuminate\Database\Eloquent\Collection;

class CommentRepository extends ModelRepository
{
	public function __construct(Repository $cache)
	{
		parent::__construct($cache, new Comment);
	}

	/**
	 * @param int      $submission_id
	 * @param int|null $parent_id
	 * @return Collection
	 */
	public function getComments($submission_id, $parent_id = null)
	{
		return $this->model
			->where('submission_id', $submission_id)
			->where('parent_id', $parent_id)
			->orderBy('score', 'DESC')
			->orderBy('created_at', 'ASC')
			->get();
	}
}
