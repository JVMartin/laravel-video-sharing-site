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

	/**
	 * @var ImageManager
	 */
	protected $imageManager;

	/**
	 * Create a new job instance.
	 */
	public function __construct(User $user, $url)
	{
		$this->user = $user;
		$this->url  = $url;

		$this->imagemanager = app(ImageManager::class);
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

		if (strlen($this->user->avatar)) {
			return;
		}

		$origFileName = $this->user->storagePath() . '/avatar-o.jpg';

		if (file_exists($origFileName)) {
			return;
		}

		copy($this->url, $origFileName);

		$fileName = md5_file($origFileName) . '.jpg';

		$this->imageManager->cropImageTo($origFileName, $fileName);

		$this->user->avatar = $fileName;
		$this->user->save();
	}
}
