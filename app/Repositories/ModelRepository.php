<?php

namespace App\Repositories;

use App\Models\MyModel;
use Illuminate\Cache\Repository;

abstract class ModelRepository extends BaseRepository
{
	/**
	 * @var MyModel
	 */
	protected $model;

	/**
	 * @var string
	 */
	protected $resourceName;

	/**
	 * @param Repository $cache
	 * @param MyModel $model
	 */
	public function __construct(Repository $cache, MyModel $model)
	{
		parent::__construct($cache);

		$this->model = $model;
		$this->resourceName = $this->model->getTable();
	}

	/**
	 * @param mixed $keyValue
	 * @return MyModel|null
	 */
	public function getByKey($keyValue)
	{
		$key = $this->resourceName . '.' . $this->model->getKeyName() . '.' . $keyValue;
		$query = $this->model;

		return $this->cache->remember($key, 10, function() use ($query, $keyValue) {
			return $query->find($keyValue);
		});
	}

	/**
	 * @param MyModel $model
	 */
	public function flush(MyModel $model)
	{
		$this->cache->forget($this->resourceName . '.' . $model->getKeyName() . '.' . $model->getKey());
	}

	/**
	 * @param array $attributes
	 * @return MyModel
	 */
	public function create(array $attributes = [])
	{
		return $this->model->create($attributes);
	}
}