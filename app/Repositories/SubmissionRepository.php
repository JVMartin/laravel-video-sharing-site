<?php

namespace App\Repositories;

use App\Models\Submission;
use Illuminate\Cache\Repository;

class SubmissionRepository extends ModelRepository
{
	public function __construct(Repository $cache)
	{
		parent::__construct($cache, new Submission);
	}
}
