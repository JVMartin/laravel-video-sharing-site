<?php

use Faker\Generator;
use App\Models\Video;
use Illuminate\Database\Seeder;
use App\Repositories\SubmissionRepository;

class SubmissionSeeder extends Seeder
{
	/**
	 * @var Generator
	 */
	protected $generator;

	/**
	 * @var SubmissionRepository
	 */
	protected $submissionRepository;

	public function __construct(
		Generator $generator,
		SubmissionRepository $submissionRepository
	)
	{
		$this->generator = $generator;
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
			$submission = $this->submissionRepository->create([
				'video_id' => $video->id,
				'user_id' => $user_id,
				'title' => $this->generator->sentence,
				'tags' => $this->tags(),
				'description' => $this->generator->paragraphs(2, true)
			]);

			// Automatically updoot our own submission.
			$submission->votes()->create([
				'user_id' => $user_id,
				'up' => 1,
			]);
		}
	}

	private function tags()
	{
		$words = $this->generator->words(random_int(3, 7));
		return implode(',', $words);
	}
}
