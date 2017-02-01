<?php

namespace App\Repositories;

use App\Models\Submission;
use Illuminate\Cache\Repository;
use Illuminate\Database\Eloquent\Model;

class SubmissionRepository extends ModelRepository
{
	public function __construct(Repository $cache)
	{
		parent::__construct($cache, new Submission);
	}

	/**
	 * @param array $attributes
	 * @return Model|Submission
	 */
	public function create(array $attributes = [])
	{
		if (array_key_exists('title', $attributes)) {
			$attributes['title'] = strip_tags($attributes['title']);
		}
		if (array_key_exists('description', $attributes)) {
			$attributes['description'] = stripUnsafeTags($attributes['description']);
		}

		return parent::create($attributes);
	}
}
