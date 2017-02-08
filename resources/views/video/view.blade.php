@extends('template')

@section('title', $submission->title)

@section('content')
	<section id="videoView">
		<div class="row">
			<div class="column small-12">
				<h1>{{ $submission->title }}</h1>
				<p>
					Submitted by
					<a href="{{ $submission->user->url() }}">
						{{ $submission->user->username }}
					</a>
					on
					{{ $submission->created_at->toDayDateTimeString() }}
				</p>
				@include('video.partials.embed', ['video' => $submission->video])
			</div>
		</div>
		@if (strlen($submission->description))
			<div class="row">
				<div class="column small-12">
					<h1>{{ $submission->description }}</h1>
				</div>
			</div>
		@endif
		<div class="row">
			<div class="column small-12">
				<div class="expander">
					<p>{!! nl2br($submission->video->description) !!}</p>
				</div>
			</div>
		</div>
	</section>
@endsection
