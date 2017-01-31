<?php

namespace App\Services;

use Google_Client;
use App\Models\Video;
use App\Repositories\VideoRepository;

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
		return null;
	}

	private function youtube()
	{
		$google = new Google_Client();
		$google->setDeveloperKey();
		$google->setClientId(env('GOOGLE_CLIENT_ID'));
		$google->setClientSecret(env('GOOGLE_CLIENT_SECRET'));
		$google->setScopes('https://www.googleapis.com/auth/youtube');
	}
}