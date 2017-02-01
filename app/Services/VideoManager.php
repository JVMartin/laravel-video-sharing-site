<?php

namespace App\Services;

use Google_Client;
use App\Models\Video;
use Google_Service_YouTube;
use App\Repositories\VideoRepository;
use Google_Service_YouTube_VideoSnippet;
use Google_Service_YouTube_VideoListResponse;

class VideoManager
{
	/**
	 * @var VideoRepository
	 */
	protected $videoRepository;

	public function __construct(VideoRepository $videoRepository)
	{
		$this->videoRepository = $videoRepository;
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
		preg_match('#(?<=(?:v|i)=)[a-zA-Z0-9-]+(?=&)|(?<=(?:v|i)\/)[^&\n]+|(?<=embed\/)[^"&\n]+|(?<=(?:v|i)=)[^&\n]+|(?<=youtu.be\/)[^&\n]+#', $url, $matches);

		return count($matches) ? $matches[0] : null;
	}

	/**
	 * Create a video entry in the database, leveraging the YouTube API.
	 *
	 * @param string $youtube_id
	 * @return Video|null
	 */
	public function createVideo($youtube_id)
	{
		$response = $this->youtube()->videos->listVideos('snippet,status', [
			'id' => $youtube_id
		]);

		if ( ! $response instanceof Google_Service_YouTube_VideoListResponse) {
			return null;
		}

		$videoDetails = $response['items'][0];
		$snippet = $videoDetails['snippet'];
		$status = $videoDetails['status'];

		if ( ! $snippet instanceof Google_Service_YouTube_VideoSnippet) {
			return null;
		}


		return null;
	}

	/**
	 * https://www.googleapis.com/youtube/v3/videos?part=contentDetails&id=kI5FYpwZMXU
	 */
	private function youtube()
	{
		static $youtube = null;
		if ($youtube === null) {
			$google = new Google_Client();
			$google->setDeveloperKey(env('YOUTUBE_API_KEY'));
			$youtube = new Google_Service_YouTube($google);
		}
		return $youtube;
	}
}