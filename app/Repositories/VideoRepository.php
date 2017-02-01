<?php

namespace App\Repositories;

use App\Models\Video;
use Illuminate\Cache\Repository;
use Illuminate\Database\Eloquent\Model;

class VideoRepository extends ModelRepository
{
	public function __construct(Repository $cache)
	{
		parent::__construct($cache, new Video);
	}

	/**
	 * @param string $youtube_id
	 * @return Video|null
	 */
	public function getByYoutubeId($youtube_id)
	{
		$key = $this->resourceName . '.youtube_id.' . $youtube_id;
		$query = $this->model->newQuery();

		return $this->cache->remember($key, 10, function() use ($query, $youtube_id) {
			return $query->where('youtube_id', $youtube_id)->first();
		});
	}

	/**
	 * @param Model|Video $model
	 */
	public function flush(Model $model)
	{
		$this->cache->forget($this->resourceName . '.youtube_id.' . $model->youtube_id);
		parent::flush($model);
	}
}
