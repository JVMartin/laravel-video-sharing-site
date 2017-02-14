<?php

namespace App\Repositories;

use App\Models\Comment;
use Illuminate\Cache\Repository;
use Illuminate\Database\Eloquent\Model;

class CommentRepository extends ModelRepository
{
	public function __construct(Repository $cache)
	{
		parent::__construct($cache, new Comment);
	}
}
