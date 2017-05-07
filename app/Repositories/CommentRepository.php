<?php

namespace App\Repositories;

use Auth;
use App\Models\Comment;
use App\Models\CommentVote;
use Illuminate\Cache\Repository;
use Illuminate\Database\Eloquent\Collection;

class CommentRepository extends ModelRepository
{
	public function __construct(Repository $cache)
	{
		parent::__construct($cache, new Comment);
	}

	/**
	 * @param int      $submission_id
	 * @param int|null $parent_id
	 * @return Collection
	 */
	public function getComments($submission_id, $parent_id = null)
	{
		$comments = $this->model->with('user')
			->where('submission_id', $submission_id)
			->where('parent_id', $parent_id)
			->orderBy('score', 'DESC')
			->orderBy('num_replies', 'DESC')
			->orderBy('created_at', 'ASC')
			->get();

		$commentsById = collect($comments)->keyBy('id')->all();

		// If the user is logged in, we need to set the flags that tell the Vue component to
		// highlight their up and downvotes.
		if ($user = Auth::user()) {
			$votes = CommentVote::whereIn('comment_id', array_keys($commentsById))
				->where('user_id', $user->id)
				->get();

			foreach ($votes as $vote) {
				if ($vote->up) {
					$commentsById[$vote->comment_id]->setUserUp();
				}
				else {
					$commentsById[$vote->comment_id]->setUserDown();
				}
			}
		}

		return $comments;
	}
}
