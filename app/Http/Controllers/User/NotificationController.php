<?php

namespace App\Http\Controllers\User;

use Auth;
use Carbon\Carbon;
use App\Models\Notification;
use Illuminate\Http\JsonResponse;
use App\Http\Controllers\Controller;

class NotificationController extends Controller
{
	public function __construct()
	{
		$this->middleware('auth');
	}

	/**
	 * Get the signed in user's notifications.
	 *
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

	/**
	 * Mark a notification as read.
	 *
	 * @param string $hashid
	 * @return JsonResponse
	 */
	public function postReadNotification($hashid)
	{
		$notification = Auth::user()->notifications()->find(decodeHash($hashid));

		if ( ! $notification) {
			return new JsonResponse(null, 403);
		}

		$notification->timestamps = false;
		$notification->read_at = Carbon::now();
		$notification->save();

		return new JsonResponse();
	}
}
