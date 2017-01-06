<?php

namespace App\Repositories;

use Illuminate\Cache\Repository;
use Illuminate\Database\Eloquent\Model;

abstract class BaseRepository
{
	/**
	 * @var Repository
	 */
	protected $cache;

	/**
	 * @var string
	 */
	protected $resourceName;

	/**
	 * @param Model $model
	 * @param Repository $cache
	 */
	public function __construct($resourceName, Repository $cache) {
		$this->cache = $cache;

		// Set the Resource Name
		$this->resourceName = $this->model->getTable();
		$this->className = get_class($model);

		// Additional setup
		$this->withTrashed = false;
	}

	/**
	 * Create a new model instance and store it in the database
	 *
	 * @param array $data
	 * @return static
	 */
	public function create(array $data)
	{
		// Remove non-fillable items from our data array
		foreach($data as $key => $value) {
			if (!in_array($key, $this->model->getFillable())) {
				unset($data[$key]);
			}
		}

		// Do we need to create a reference id?
		if ($this->model->isFillable('ref') && !isset($data['ref'])) {
			$data['ref'] = $this->generateReferenceId();
		}

		// Create the new model object
		$model = $this->model->create($data);

		// Return the new model object
		return $model;
	}

	/**
	 * Update a Model Object Instance
	 *
	 * @param int|string|Model $model
	 * @param array $data
	 * @return \Illuminate\Support\Collection|null|static
	 */
	public function update($model, array $data)
	{

		// We may need to convert the id into a model instance
		$model = $this->normalizeModel($model);

		// Set the new values on the Model Object
		foreach ($data as $key => $value) {
			if ($this->model->isFillable($key)) {
				$model->$key = $value;
			}
		}

		// Save the changes to the database
		$model->save();

		// Flush the cache
		$this->flush($model);

		// Return the updated model
		return $model;
	}

	/**
	 * Delete a model object
	 *
	 * @param string|Model
	 *
	 * @return Model
	 */
	public function delete($model)
	{
		// Resolve the hash string if necessary
		$model = $this->normalizeModel($model);

		//Flush the cache
		$this->flush($model);

		// Delete the model
		$model->delete();

		return $model;
	}

	/**
	 * Retrieve a single model object, using its id
	 *
	 * @param integer $id
	 * @return null|Model
	 */
	public function retrieveById($id)
	{
		$key = $this->resourceName . '.id.' . (string)$id;

		$query = $this->model;

		if ($this->withTrashed) {
			$query = $query->withTrashed();
		}

		return $this->cache->remember($key, 10, function () use ($query, $id) {
			return $query->find($id);
		});
	}

	/**
	 * Retrieve a single model, using its hash value
	 *
	 * @param string $hash
	 * @return null|Model
	 */
	public function retrieveByHash($hash)
	{
		$id = decodeHash($hash);

		if ($id) {
			$key = $this->resourceName . '.hash.' . $hash;

			$query = $this->model;

			if ($this->withTrashed) {
				$query = $query->withTrashed();
			}

			return $this->cache->remember($key, 10, function() use ($query, $id) {
				return $query->find($id);
			});
		}

		return null;
	}

	/**
	 * Flush the cache for this Model Object instance
	 *
	 * @param Model $model
	 * @return void
	 */
	public function flush(Model $model)
	{
		$this->cache->forget($this->resourceName . '.id.' . $model->id);
		$this->cache->forget($this->resourceName . '.hash.' . $model->hash);
	}

	/**
	 * Return the Repository Model instance
	 *
	 * @return Model
	 */
	public function getModel()
	{
		return $this->model;
	}

	/**
	 * Convert hash string to model object, if necessary
	 *
	 * @param $model
	 * @return Model|null
	 */
	protected function normalizeModel($model)
	{
		// Is this an instance of the model already?
		if ($model instanceof $this->className) {
			return $model;
		}

		// Is this the model id in string form?
		if (is_string($model) && ctype_digit($model)) {
			return $this->retrieveById(intval($model));
		}

		// Is this the model hashid in string form?
		if (is_string($model) && !ctype_digit($model)) {
			return $this->retrieveByHash($model);
		}

		// Is this the model id in integer form?
		if (is_integer($model)) {
			return $this->retrieveById($model);
		}

		return null;
	}

	/**
	 * Allow the retrieval methods to consider records that have been "soft" deleted
	 *
	 * @return $this
	 */
	public function withTrashed()
	{
		$this->withTrashed = true;

		return $this;
	}

	/**
	 * Prevent the retrieval methods from considering records that have been soft deleted
	 *
	 * @return $this
	 */
	public function withoutTrashed()
	{
		$this->withTrashed = false;

		return $this;
	}

	/**
	 * Each repository will be responsible for implementing its own reference generator.
	 *
	 * @return string
	 */
	abstract function generateReferenceId();
}