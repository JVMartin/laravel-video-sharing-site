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
	 * @param Repository $cache
	 * @param MyModel $model
	 */
	public function __construct(Repository $cache, MyModel $model)
	{
		parent::__construct($cache);

		$this->model = $model;
	}
}