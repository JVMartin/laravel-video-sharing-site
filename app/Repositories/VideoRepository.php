<?php

namespace App\Repositories;

use App\Models\Video;
use Illuminate\Cache\Repository;

class VideoRepository extends ModelRepository
{
	public function __construct(Repository $cache)
	{
		parent::__construct($cache, new Video);
	}
}
