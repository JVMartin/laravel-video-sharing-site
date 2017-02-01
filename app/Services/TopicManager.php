<?php

namespace App\Services;

use App\Repositories\TopicRepository;

class TopicManager
{
	/**
	 * @var TopicRepository
	 */
	protected $topicRepository;

	public function __construct(TopicRepository $topicRepository)
	{
		$this->topicRepository = $topicRepository;
	}
}
