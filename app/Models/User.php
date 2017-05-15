<?php

namespace App\Models;

use Auth;
use Mail;
use App\Mail\ResetPasswordLinkEmail;
use Illuminate\Auth\Authenticatable;
use Illuminate\Auth\Passwords\CanResetPassword;
use Illuminate\Foundation\Auth\Access\Authorizable;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Illuminate\Contracts\Auth\Access\Authorizable as AuthorizableContract;
use Illuminate\Contracts\Auth\CanResetPassword as CanResetPasswordContract;

class User extends Model implements
	AuthenticatableContract,
	AuthorizableContract,
	CanResetPasswordContract
{
	use Authenticatable, Authorizable, CanResetPassword;

	/**
	 * The attributes that should be hidden for arrays.
	 *
	 * @var array
	 */
	protected $hidden = [
		'id', 'email', 'first_name', 'last_name', 'password', 'remember_token',
		'last_sign_in', 'created_at', 'updated_at', 'avatar'
	];

	/**
	 * The accessors to append to the model's array form.
	 *
	 * @var array
	 */
	protected $appends = ['hash', 'url', 'avatar_url'];

	/**
	 * Is this user followed by the signed-in user?
	 *
	 * @return bool
	 */
	public function followed()
	{
		if ( ! Auth::check()) return false;

		return ($this->followers()->where('follower_id', Auth::user()->id)->count()) ? true : false;
	}

	public function followers()
	{
		return $this->belongsToMany(User::class, 'follows', 'leader_id', 'follower_id');
	}

	public function leaders()
	{
		return $this->belongsToMany(User::class, 'follows', 'follower_id', 'leader_id');
	}

	public function notifications()
	{
		return $this->hasMany(Notification::class);
	}

	/**
	 * Send the password reset notification.
	 *
	 * @param string $token
	 * @return void
	 */
	public function sendPasswordResetNotification($token)
	{
		Mail::to($this->email)->send(new ResetPasswordLinkEmail($this->hash, $token));
	}

	/**
	 * Determine whether this user uses social authentication instead of a password.
	 *
	 * @return bool
	 */
	public function usesSocialAuthentication()
	{
		return (strlen($this->password) === 0);
	}

	public function getAvatarUrlAttribute()
	{
		if (strlen($this->avatar)) {
			return '/storage/u/' . $this->hash . '/' . $this->avatar;
		}

		return '/img/avatar-placeholder.png';
	}

	public function storagePath()
	{
		$path = storage_path('app/public/u/' . $this->hash);

		if ( ! file_exists($path)) {
			mkdir($path, 0775);
		}

		return $path;
	}

	public function url()
	{
		return route('user.profile', $this->username);
	}

	public function getUrlAttribute()
	{
		return $this->url();
	}
}
