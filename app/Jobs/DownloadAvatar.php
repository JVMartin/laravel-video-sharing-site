<?php

namespace App\Jobs;

use App\Models\User;
use Illuminate\Bus\Queueable;
use App\Services\ImageManager;
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

	public function __construct(User $user, $url)
	{
		$this->user = $user;
		$this->url = $url;
	}

	/**
	 * Execute the job.
	 *
	 * @return void
	 */
	public function handle()
	{
		$imageManager = app(ImageManager::class);

		if ( ! strlen($this->url)) {
			return;
		}

		if (strlen($this->user->avatar)) {
			return;
		}

		$origFilePath = $this->user->storagePath() . '/avatar-o.jpg';

		if (file_exists($origFilePath)) {
			return;
		}

		copy($this->url, $origFilePath);

		$fileName = md5_file($origFilePath) . '.jpg';
		$filePath = $this->user->storagePath() . '/' . $fileName;

		$imageManager->cropImageTo($origFilePath, $filePath);

		$this->user->avatar = $fileName;
		$this->user->save();
	}
}
