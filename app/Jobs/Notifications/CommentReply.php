<?php

namespace App\Jobs\Notifications;

use App\Models\Comment;

class CommentReply extends SendNotification
{
	/**
	 * @var Comment
	 */
	protected $comment;

	public function __construct(Comment $comment)
	{
		$this->comment = $comment;
	}

	/**
	 * Execute the job.
	 *
	 * @return void
	 */
	public function handle()
	{
		$comment = $this->comment;
		$user = $this->comment->user;

		$notification = $this->getNotification($user, $comment, 'replies');

		$notification->count = $comment->replies()->count();
		$notification->read_at = null;
		$notification->save();
	}
}
