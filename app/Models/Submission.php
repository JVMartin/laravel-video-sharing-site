<?php

namespace App\Models;

use Cartalyst\Tags\TaggableTrait;
use Cartalyst\Tags\TaggableInterface;

class Submission extends Model implements TaggableInterface
{
	use Votable;
	use TaggableTrait;

	/**
	 * The attributes that should be hidden for arrays.
	 *
	 * @var array
	 */
	protected $hidden = [
		'id', 'video_id', 'user_id'
	];

	/**
	 * @var array
	 */
	protected $with = ['video'];

	/**
	 * @var array
	 */
	protected $appends = ['hash', 'url', 'user_up', 'user_down'];

	public function video()
	{
		return $this->belongsTo(Video::class);
	}

	public function user()
	{
		return $this->belongsTo(User::class);
	}

	public function comments()
	{
		return $this->hasMany(Comment::class);
	}

	public function votes()
	{
		return $this->hasMany(SubmissionVote::class);
	}

	public function ratingPercent()
	{
		$totalVotes = $this->num_up + $this->num_down;
		if ($totalVotes == 0) {
			issue('Submission id ' . $this->id . ' has no votes.');
			return 100;
		}
		$ratio = $this->num_up / $totalVotes;
		return $ratio * 100;
	}

	//------------------------------------------------------------------------------
	// Very useful but we use a dedicated column now.
	//------------------------------------------------------------------------------
//	public function commentsCount()
//	{
//		return $this->comments()
//			->selectRaw('submission_id, count(*) AS aggregate')
//			->groupBy('submission_id');
//	}
//	public function getCommentsCountAttribute()
//	{
//		if ( ! array_key_exists('commentsCount', $this->relations)) {
//			$this->load('commentsCount');
//		}
//
//		$commentsCount = $this->getRelation('commentsCount');
//
//		return ($commentsCount->count()) ? $commentsCount->first()->aggregate : 0;
//	}

	public function slugHashid()
	{
		return $this->slug . '-' . $this->hash;
	}

	public function url()
	{
		return route('video.view', $this->slugHashid());
	}

	public function getUrlAttribute()
	{
		return $this->url();
	}
}
