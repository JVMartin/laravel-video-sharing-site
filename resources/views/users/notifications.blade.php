@extends('template')

@section('title', 'Notifications')

@section('content')
	<section id="usersNotifications">
		@if ($notifications->count())
			@if (Auth::user()->unreadNotifications()->count())
				<a class="button" href="{{ route('notifications.read-all') }}">
					Mark all as read
				</a>
			@endif
		@else
			<div class="row column">
				<div class="callout default">
					No notifications.
				</div>
			</div>
		@endif
		@foreach ($notifications as $notification)
			@php($notifiable = $notification->notifiable)
				@if ($notifiable instanceof App\Models\Submission)
					<a class="notification" href="{{ $notifiable->url() }}" target="_blank" data-hashid="{{ $notification->hash }}">
						<div class="row">
							<div class="column small-2 large-1">
								<img src="https://img.youtube.com/vi/{{ $notifiable->video->youtube_id }}/default.jpg" />
							</div>
							<div class="column small-10 large-11">
								@if ($notification->read_at)
									<i class="fa fa-circle-o"></i>
								@else
									<i class="fa fa-circle"></i>
								@endif
								@if ($notification->type == 'comments')
									Your submission has {{ $notification->count }} comment{{ $notification->count > 1 ? 's' : '' }}.
								@endif
							</div>
						</div>
					</a>
				@elseif ($notifiable instanceof App\Models\Comment)
					<a class="notification" href="{{ $notifiable->url() }}" target="_blank" data-hashid="{{ $notification->hash }}">
						<div class="row">
							<div class="column small-2 large-1">
								<img src="https://img.youtube.com/vi/{{ $notifiable->submission->video->youtube_id }}/default.jpg" />
							</div>
							<div class="column small-10 large-11">
								@if ($notification->read_at)
									<i class="fa fa-circle-o"></i>
								@else
									<i class="fa fa-circle"></i>
								@endif
								@if ($notification->type == 'replies')
									Your comment
									"{{ str_limit(strip_tags($notifiable->contents), 160) }}"
									has {{ $notification->count }} repl{{ $notification->count > 1 ? 'ies' : 'y' }}.
								@endif
							</div>
						</div>
					</a>
				@elseif ($notifiable instanceof App\Models\User)
					<a class="notification" href="{{ $notifiable->url() }}" target="_blank" data-hashid="{{ $notification->hash }}">
						<div class="row">
							<div class="column small-2 large-1">
								<img src="{{ $notifiable->avatar_url }}" />
							</div>
							<div class="column small-10 large-11">
								@if ($notification->read_at)
									<i class="fa fa-circle-o"></i>
								@else
									<i class="fa fa-circle"></i>
								@endif
								@if ($notification->type == 'follow')
									{{ $notifiable->username }} started following you.
								@endif
							</div>
						</div>
					</a>
				@endif
		@endforeach
		<div class="row column text-center">
			{{ $notifications->links('pagination::foundation') }}
		</div>
	</section>
@endsection
