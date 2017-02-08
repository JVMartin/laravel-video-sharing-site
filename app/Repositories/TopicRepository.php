<?php

namespace App\Repositories;

use DB;
use App\Models\Topic;
use Illuminate\Cache\Repository;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

class TopicRepository extends ModelRepository
{
	public function __construct(Repository $cache)
	{
		parent::__construct($cache, new Topic);
	}

	/**
	 * @param string $google_id
	 * @return Topic|null
	 */
	public function getByGoogleId($google_id)
	{
		$key = $this->resourceName . '.google_id.' . $google_id;
		$query = $this->model->newQuery();

		return $this->cache->remember($key, 10, function() use ($query, $google_id) {
			return $query->where('google_id', $google_id)->first();
		});
	}

	/**
	 * @param array $google_ids
	 * @return Collection|null
	 */
	public function getByGoogleIds(array $google_ids)
	{
		return $this->model->whereIn('google_id', $google_ids)->get();
	}

	/**
	 * {@inheritdoc}
	 */
	public function create(array $attributes = [])
	{
		// Only create it if it doesn't already exist.
		DB::transaction(function() use (&$model, $attributes) {
			$model = $this->model->where('google_id', $attributes['google_id'])->first();
			if ( ! $model) {
				$model = $this->model->create($attributes);
			}
		});
		return $model;
	}

	/**
	 * @param Model|Topic $model
	 * @return void
	 */
	public function flush(Model $model)
	{
		$this->cache->forget($this->resourceName . '.google_id.' . $model->google_id);
		parent::flush($model);
	}
}
