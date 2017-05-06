<?php

namespace App\Jobs;

use DB;
use Debugbar;
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
		$commentRepository = app(CommentRepository::class);
		$comment = $this->comment;

		// First let's get the number of replies it has.
		// Include "submission_id" for performance increase from index on that column.
		$num_replies = Comment::where('submission_id', $comment->submission_id)
			->where('parent_id', $comment->id)
			->count();

		// Next, let's get the votes.
		$votes = DB::table('comments_votes')
			->select(DB::raw('SUM(up) AS num_up, SUM(down) AS num_down'))
			->where('comment_id', $comment->id)
			->groupBy('comment_id')
			->first();

		$commentRepository->update($comment, [
			'score' => $votes->num_up - $votes->num_down,
			'num_up' => $votes->num_up,
			'num_down' => $votes->num_down,
			'num_replies' => $num_replies,
		]);
	}
}
