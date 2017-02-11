<?php

use App\Models\Video;
use Illuminate\Database\Seeder;
use App\Repositories\SubmissionRepository;

class SubmissionSeeder extends Seeder
{
	/**
	 * @var SubmissionRepository
	 */
	protected $submissionRepository;

	public function __construct(
		SubmissionRepository $submissionRepository
	)
	{
		$this->submissionRepository = $submissionRepository;
	}

	/**
	 * Run the database seeds.
	 *
	 * @return void
	 */
	public function run()
	{
		$user_id = 1;
		foreach (Video::all() as $video) {
			$user_id = ($user_id == 1) ? 2 : 1;
			$this->submissionRepository->create([
				'video_id' => $video->id,
				'user_id' => $user_id,
				'title' => $request->title,
				'tags' => $request->tags,
				'description' => $request->description
			]);
		}
	}
}
