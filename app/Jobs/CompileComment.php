<?php

namespace App\Jobs;

use DB;
use App\Models\Comment;
use Illuminate\Bus\Queueable;
use App\Repositories\CommentRepository;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;

class CompileComment implements ShouldQueue
{
	use InteractsWithQueue, Queueable, SerializesModels;

	/**
	 * @var Comment
	 */
	protected $comment;

	/**
	 * @var CommentRepository
	 */
	protected $commentRepository;

	public function __construct(Comment $comment)
	{
		$this->comment = $comment;

		$this->commentRepository = app(CommentRepository::class);
	}

	/**
	 * Execute the job.
	 *
	 * @return void
	 */
	public function handle()
	{
		$comment = $this->comment;

		// First let's get the number of replies it has.
		// Include "submission_id" for performance increase from index on that column.
		$num_replies = Comment::where('submission_id', $comment->submission_id)
			->where('parent_id', $comment->id)
			->count();

		// Next, let's get the votes.
		DB::table('comments_votes')
			->select(DB::raw(''))
			->groupBy('comment_id')
			->where();

		$this->commentRepository->update($comment, [
			'num_replies' => $num_replies
		]);
	}
}
