<?php

/**
 * Strip all unsafe tags.
 *
 * @param string $string
 * @return int|array|null
 */
function stripUnsafeTags($string)
{
	$config = HTMLPurifier_Config::createDefault();

	// Set the serializer's cache path.
	$config->set('Cache.SerializerPath', storage_path('app/html-purifier'));

	// Allow YouTube and Vimeo
	$config->set('HTML.SafeIframe', true);
	$config->set('URI.SafeIframeRegexp', '%^(https?:)?//(www\.youtube(?:-nocookie)?\.com/embed/|player\.vimeo\.com/video/)%');

	$purifier = new HTMLPurifier($config);
	return trim($purifier->purify($string));
}

//function stripUnsafeTags($string)
//{
//	static $whitelist = '';
//
//	if ( ! strlen($whitelist)) {
//		$whitelist = implode('', [
//			// Links
//			'<a>',
//
//			// Text
//			'<p>',
//			'<br>',
//			'<strong>',
//			'<b>',
//			'<em>',
//			'<i>',
//
//			// Images, videos
//			'<img>',
//		]);
//	}
//
//	return strip_tags($string, $whitelist);
//}

/**
 * Report an issue to the site administrators.
 */
function issue($message, $extra = null)
{
	if (is_array($extra)) {
		Sentry::captureMessage($message, [], [
			'extra' => $extra
		]);
	}
	else {
		Sentry::captureMessage($message);
	}
}
