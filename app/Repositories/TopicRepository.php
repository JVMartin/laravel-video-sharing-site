<?php

namespace App\Repositories;

use App\Models\Topic;
use Illuminate\Cache\Repository;

class TopicRepository extends ModelRepository
{
	public function __construct(Repository $cache)
	{
		parent::__construct($cache, new Topic);
	}
}
