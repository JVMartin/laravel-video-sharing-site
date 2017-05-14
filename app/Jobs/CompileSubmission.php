<?php

namespace App\Jobs;

use DB;
use App\Models\Comment;
use App\Models\Submission;
use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use App\Repositories\SubmissionRepository;
use Illuminate\Contracts\Queue\ShouldQueue;

class CompileSubmission implements ShouldQueue
{
	use InteractsWithQueue, Queueable, SerializesModels;

	/**
	 * @var Comment
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
		$submissionRepository = app(SubmissionRepository::class);
		$submission = $this->submission;

		// First let's get the number of comments it has.
		$num_comments = Comment::where('submission_id', $submission->submission_id)
			->count();

		// Next, let's get the votes.
		$votes = DB::table('submissions_votes')
			->select(DB::raw('SUM(up) AS num_up, SUM(down) AS num_down'))
			->where('submission_id', $submission->id)
			->groupBy('submission_id')
			->first();

		$submissionRepository->update($submission, [
			'score' => $votes->num_up - $votes->num_down,
			'num_up' => $votes->num_up,
			'num_down' => $votes->num_down,
			'num_comments' => $num_comments,
		]);
	}
}
