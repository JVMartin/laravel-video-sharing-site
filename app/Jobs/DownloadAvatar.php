<?php

namespace App\Jobs;

use App\Services\ImageManager;
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

		$origFile = $userImgPath . '/avatar-o.jpg';
		$resized = $userImgPath . '/avatar.jpg';

		// It's already been saved, no need to do so again.
		if (file_exists($origFile)) {
			return;
		}

		if ( ! file_exists($userImgPath)) {
			mkdir($userImgPath, 0775);
		}

		// Download the image.
		copy($this->url, $origFile);

		$imageManager = app(ImageManager::class);
		$imageManager->cropImageTo($origFile, $resized);

		$this->user->has_avatar = true;
		$this->user->save();
	}
}
