<?php

namespace App\Services;

use Imagick;
use App\Models\User;

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

	/**
	 * @param User $user
	 */
	public function deleteAvatarIfExists($user)
	{
		// If the user has an avater, delete it.
		if (strlen($user->avatar)) {
			$existingAvatar = $user->storagePath() . '/' . $user->avatar;
			if (file_exists($existingAvatar)) {
				unlink($existingAvatar);
			}
		}
	}
}
