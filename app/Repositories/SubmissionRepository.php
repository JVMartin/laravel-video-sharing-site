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

	private function massageAttributes(array &$attributes = [])
	{
		if (array_key_exists('title', $attributes)) {
			$attributes['title'] = strip_tags($attributes['title']);

			// Generate a slug from the title.
			$attributes['slug'] = str_slug($attributes['title']);
		}
		if (array_key_exists('tags', $attributes)) {
			$attributes['tags'] = strip_tags($attributes['tags']);
		}
		if (array_key_exists('description', $attributes)) {
			$attributes['description'] = stripUnsafeTags($attributes['description']);
		}
	}

	/**
	 * @param array $attributes
	 * @return Model|Submission
	 */
	public function create(array $attributes = [])
	{
		$this->massageAttributes($attributes);

		$tags = $attributes['tags'];
		unset($attributes['tags']);

		$model = parent::create($attributes);

		$model->tag($tags);

		return $model;
	}
}
