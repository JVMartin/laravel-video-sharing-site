<?php

namespace App\Models;

use Mail;
use App\Mail\ResetPasswordLinkEmail;
use Illuminate\Auth\Authenticatable;
use Illuminate\Notifications\Notifiable;
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
	use Authenticatable, Authorizable, CanResetPassword, Notifiable;

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
	protected $appends = ['hash', 'avatar_url'];

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
}
