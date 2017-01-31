<?php

namespace App\Services;


class VideoManager
{
	public function __construct()
	{
		//
	}

	/**
	 * Extract a video id from an url.
	 * See: http://stackoverflow.com/questions/3392993/php-regex-to-get-youtube-video-id
	 *
	 * @param string $url
	 * @return string|null
	 */
	public function extractVideoId($url)
	{
		preg_match('#(?<=(?:v|i)=)[a-zA-Z0-9-]+(?=&)|(?<=(?:v|i)\/)[^&\n]+|(?<=embed\/)[^"&\n]+|(?<=(?:v|i)=)[^&\n]+|(?<=youtu.be\/)[^&\n]+#', $url, $matches);

		return count($matches) ? $matches[0] : null;
	}
}