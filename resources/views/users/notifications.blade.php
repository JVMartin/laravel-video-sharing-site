@extends('template')

@section('title', 'Notifications')

@section('content')
	<section id="usersNotifications">
		@foreach ($notifications as $notification)
			@php($notifiable = $notification->notifiable)
			<div class="row column">
					@if ($notifiable instanceof App\Models\Submission)
						<a class="notification" href="{{ $notifiable->url() }}" target="_blank">
							@if ($notification->read_at)
								<i class="fa fa-circle-o"></i>
							@else
								<i class="fa fa-circle"></i>
							@endif
							@if ($notification->type == 'comments')
								Your submission "{{ $notifiable->title }}" has {{ $notification->count }} comment{{ $notification->count > 1 ? 's' : '' }}.
							@endif
						</a>
					@endif
			</div>
		@endforeach
		@if ( ! $notifications->count())
			<div class="row column">
				<div class="callout default">
					No notifications.
				</div>
			</div>
		@endif
		<div class="row column text-center">
			{{ $notifications->links('pagination::foundation') }}
		</div>
	</section>
@endsection
