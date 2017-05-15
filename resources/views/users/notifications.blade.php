@extends('template')

@section('title', 'Notifications')

@section('content')
	<section id="usersNotifications">
		@foreach ($notifications as $notification)
			@php($notifiable = $notification->notifiable)
			<div class="row column">
				<div class="notification">
					@if ($notifiable instanceof App\Models\Submission)
						@if ($notification->type == 'comments')
							Your submission "{{ $notifiable->title }}" has {{ $notification->count }} comment{{ $notification->count > 1 ? 's' : '' }}.
						@endif
					@endif
				</div>
			</div>
		@endforeach
	</section>
@endsection
