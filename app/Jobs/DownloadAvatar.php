<?php

namespace App\Jobs;

use Imagick;
use App\Models\User;
use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;

class DownloadAvatar implements ShouldQueue
{
	use InteractsWithQueue, Queueable, SerializesModels;

	/**
	 * @var User
	 */
	protected $user;

	/**
	 * @var string
	 */
	protected $url;

	/**
	 * Create a new job instance.
	 */
	public function __construct(User $user, $url)
	{
		$this->user = $user;
		$this->url  = $url;
	}

	/**
	 * Execute the job.
	 *
	 * @return void
	 */
	public function handle()
	{
		if ( ! strlen($this->url)) {
			return;
		}

		$userImgPath = public_path('img/u/' . $this->user->hash);

		$destFile = $userImgPath . '/avatar-o.jpg';
		$resized = $userImgPath . '/avatar.jpg';

		// It's already been saved, no need to do so again.
		if (file_exists($destFile)) {
			return;
		}

		if ( ! file_exists($userImgPath)) {
			mkdir($userImgPath, 0775);
		}

		// Download the image.
		copy($this->url, $destFile);

		// Turn it into a 200 x 200 square.
		$image = new Imagick($destFile);
		$image->cropThumbnailImage(200, 200);
		$image->writeImage($resized);

		$this->user->avatar = true;
		$this->user->save();
	}
}
