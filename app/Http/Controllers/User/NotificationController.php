<?php

namespace App\Http\Controllers\User;

use Auth;
use App\Models\Notification;
use App\Http\Controllers\Controller;

class NotificationController extends Controller
{
	public function __construct()
	{
		$this->middleware('auth');
	}

	/**
	 * @return \Illuminate\View\View
	 */
	public function getNotifications()
	{
		$notifications = Notification::where('user_id', Auth::user()->id)
			->orderBy('updated_at', 'DESC')
			->paginate();

		return view('users.notifications', [
			'notifications' => $notifications,
		]);
	}
}
