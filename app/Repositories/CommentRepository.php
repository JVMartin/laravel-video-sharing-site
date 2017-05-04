<?php

namespace App\Repositories;

use App\Models\Comment;
use Illuminate\Cache\Repository;

class CommentRepository extends ModelRepository
{
	public function __construct(Repository $cache)
	{
		parent::__construct($cache, new Comment);
	}

	public function getBySubmissionId($id, $parent_id = null)
	{
		return $this->model
			->where('submission_id', $id)
			->where('parent_id', $parent_id)
			->orderBy('score', 'DESC')
			->get();
	}
}
