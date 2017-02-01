<?php

namespace App\Services;

use App\Models\Video;
use GuzzleHttp\Client;
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

	public function setTopics(Video $video, array $google_ids)
	{
		$this->handleTopics($google_ids);
	}

	public function setRelevantTopics(Video $video, array $google_ids)
	{
		$this->handleTopics($google_ids);
	}

	private function handleTopics(array $google_ids)
	{
		$inserts = [];
		foreach ($google_ids as $google_id) {
			$topic = $this->topicRepository->getByGoogleId($google_id);

			if ( ! $topic) {
				$inserts []= $google_id;
			}
		}

		$this->insertTopics($inserts);
	}

	private function insertTopics(array $google_ids)
	{
		if ( ! count($google_ids)) {
			return;
		}

		$query = 'key=' . urlencode(env('GOOGLE_API_KEY'));
		foreach ($google_ids as $google_id) {
			$query .= '&ids=' . urlencode($google_id);
		}

		dd($query);

		$client = new Client();

		$response = $client->request('GET', 'https://kgsearch.googleapis.com/v1/entities:search', [
			'query' => $query
		]);
	}
}
