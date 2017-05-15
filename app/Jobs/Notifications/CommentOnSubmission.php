<?php

namespace App\Jobs\Notifications;

use App\Models\Submission;

class CommentOnSubmission extends SendNotification
{
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

		$notification = $this->getNotification($user, $submission, 'comments');

		$notification->count = $submission->comments()->whereNull('parent_id')->count();
		$notification->read_at = null;
		$notification->save();
	}
}
