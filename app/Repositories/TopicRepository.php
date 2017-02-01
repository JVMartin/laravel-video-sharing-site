<?php

namespace App\Repositories;

use App\Models\Topic;
use Illuminate\Cache\Repository;
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
	 * @param Model|Topic $model
	 */
	public function flush(Model $model)
	{
		$this->cache->forget($this->resourceName . '.google_id.' . $model->google_id);
		parent::flush($model);
	}
}
