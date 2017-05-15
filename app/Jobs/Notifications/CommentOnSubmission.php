<?php

namespace App\Jobs\Notifications;

use App\Models\Submission;
use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;

class CommentOnSubmission implements ShouldQueue
{
	use InteractsWithQueue, Queueable, SerializesModels;

	/**
	 * @var Submission
	 */
	protected $submission;

	public function __construct(Submission $submission)
	{
		$this->submission = $submission;
	}

	/**
	 * Execute the job.
	 *
	 * @return void
	 */
	public function handle()
	{
		$submission = $this->submission;
		$user = $this->submission->user;

		$notification = $user->notifications()
			->where('notifiable_id', $submission->id)
			->where('notifiable_type', get_class($submission))
			->where('type', 'comments')
			->first();

		if ( ! $notification) {
			$notification = $user->notifications()->create([
				'notifiable_id' => $submission->id,
				'notifiable_type' => get_class($submission),
				'type' => 'comments'
			]);
		}

		$notification->count = $submission->comments()->whereNull('parent_id')->count();
		$notification->read_at = null;
		$notification->save();
	}
}
