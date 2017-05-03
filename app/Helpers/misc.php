<?php

/**
 * Strip all except some safe tags.
 *
 * @param string $string
 * @return int|array|null
 */
function stripUnsafeTags($string)
{
	static $whitelist = '';

	if ( ! strlen($whitelist)) {
		$whitelist = implode('', [
			// Links
			'<a>',

			// Text
			'<p>',
			'<br>',
			'<strong>',
			'<b>',
			'<em>',
			'<i>',

			// Images, videos
			'<img>',
		]);
	}

	return strip_tags($string, $whitelist);
}

/**
 * Report an issue to the site administrators.
 */
function issue($message)
{
	Sentry::captureMessage($message);
}
