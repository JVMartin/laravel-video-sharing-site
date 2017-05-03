<?php

namespace App\Services;

use Carbon\Carbon;
use Google_Client;
use App\Models\Video;
use Google_Service_YouTube;
use App\Repositories\VideoRepository;
use Illuminate\Database\Eloquent\Model;
use Google_Service_YouTube_VideoStatus;
use Google_Service_YouTube_VideoSnippet;
use Google_Service_YouTube_VideoTopicDetails;
use Google_Service_YouTube_VideoListResponse;

class VideoManager
{
	/**
	 * @var VideoRepository
	 */
	protected $videoRepository;

	/**
	 * @var TopicManager
	 */
	protected $topicManager;

	public function __construct(
		VideoRepository $videoRepository,
		TopicManager $topicManager
	)
	{
		$this->videoRepository = $videoRepository;
		$this->topicManager = $topicManager;
	}

	/**
	 * Extract the youtube id from an url.
	 * See: http://stackoverflow.com/questions/3392993/php-regex-to-get-youtube-video-id
	 *
	 * @param string $url
	 * @return string|null
	 */
	public function extractYoutubeId($url)
	{
		preg_match('#(?<=(?:v|i)=)[a-zA-Z0-9-]+(?=&)|(?<=(?:v|i)\/)[^&\n]+|' .
			'(?<=embed\/)[^"&\n]+|(?<=(?:v|i)=)[^&\n]+|(?<=youtu.be\/)[^&\n]+#', $url, $matches);

		return count($matches) ? $matches[0] : null;
	}

	/**
	 * Create a video entry in the database, leveraging the YouTube API.
	 *
	 * @param string $youtube_id
	 * @return Video|null
	 */
	public function importVideoIfNotExists($youtube_id)
	{
		$video = $this->videoRepository->getByYoutubeId($youtube_id);

		if ( ! $video) {
			$video = $this->importVideo($youtube_id);
		}

		return $video;
	}

	/**
	 * Import a video from the YouTube API into the database.
	 *
	 * @param string $youtube_id
	 * @return Model|Video|null
	 */
	private function importVideo($youtube_id)
	{
		$response = $this->youtube()->videos->listVideos('snippet,status,topicDetails', [
			'id' => $youtube_id
		]);

		if ( ! $response instanceof Google_Service_YouTube_VideoListResponse) {
			issue("Import video issue: response not Google_Service_YouTube_VideoListResponse ($youtube_id)");
			return null;
		}
		if ( ! is_array($response['items'])) {
			issue("Import video issue: response['items'] not an array ($youtube_id)");
			return null;
		}

		// This happens when the video does not exist anymore - there is a response, but the items
		// array is empty.
		if ( ! isset($response['items'][0])) {
			issue("Import video issue: response['items'] does not contain items ($youtube_id)");
			return null;
		}

		$videoDetails = $response['items'][0];
		$snippet = $videoDetails['snippet'];
		$status = $videoDetails['status'];
		$topicDetails = $videoDetails['topicDetails'];

		if ( ! $snippet instanceof Google_Service_YouTube_VideoSnippet) {
			issue("Import video issue: snippet not Google_Service_YouTube_VideoSnippet ($youtube_id)");
			return null;
		}
		if ( ! $status instanceof Google_Service_YouTube_VideoStatus) {
			issue("Import video issue: status not Google_Service_YouTube_VideoStatus ($youtube_id)");
			return null;
		}
		if ( ! $topicDetails instanceof Google_Service_YouTube_VideoTopicDetails) {
			issue("Import video issue: topicDetails not Google_Service_YouTube_VideoTopicDetails ($youtube_id)");
			return null;
		}

		$video = $this->videoRepository->create([
			'youtube_id' => $youtube_id,
			'title' => $snippet->title,
			'description' => $snippet->description,
			'embeddable' => $status->embeddable,
			'privacy_status' => $status->privacyStatus,
			'published_at' => new Carbon($snippet->publishedAt)
		]);

		// Add the tags that YouTube provides.
		if (is_array($snippet->tags) && count($snippet->tags)) {
			$video->tag($snippet->tags);
		}

		// Add the topics that YouTube provides.
		if (is_array($topicDetails->topicIds) && count($topicDetails->topicIds)) {
			$this->topicManager->setTopics($video, $topicDetails->topicIds);
		}
		if (is_array($topicDetails->relevantTopicIds) && count($topicDetails->relevantTopicIds)) {
			$this->topicManager->setTopics($video, $topicDetails->relevantTopicIds, 'relevantTopicId');
		}

		return $video;
	}

	/**
	 * https://www.googleapis.com/youtube/v3/videos?part=contentDetails&id=kI5FYpwZMXU
	 */
	private function youtube()
	{
		static $youtube = null;
		if ($youtube === null) {
			$google = new Google_Client();
			$google->setDeveloperKey(env('GOOGLE_API_KEY'));
			$youtube = new Google_Service_YouTube($google);
		}
		return $youtube;
	}
}
