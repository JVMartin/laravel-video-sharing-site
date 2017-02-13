<?php

namespace App\Services;

use Imagick;

class ImageManager
{
	/**
	 * @param string $source       The full path of the source image.
	 * @param string $destination  The full path of the destination image.
	 */
	public function cropImageTo($source, $destination)
	{
		$image = new Imagick($source);
		$image->cropThumbnailImage(200, 200);
		$image->writeImage($destination);
	}
}
