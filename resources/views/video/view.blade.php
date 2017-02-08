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
			</div>
		</div>
		<div class="row">
			<div class="column large-8">
				@include('video.partials.embed', ['video' => $submission->video])
			</div>
			<div class="column large-4">
				@if (strlen($submission->description))
					<div class="row">
						<div class="column small-12">
							<h1>{{ $submission->description }}</h1>
						</div>
					</div>
				@endif
				<div class="row">
					<div class="column small-12">
						<p>Youtube Description</p>
						<div class="expander">
							<p>{!! nl2br($submission->video->description) !!}</p>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="column small-12">
						<p>Tags</p>
						<div class="expander">
							@foreach ($submission->tags as $tag)
								<a href="{{ route('browse.by-tag', $tag->slug) }}" class="tag">
									{{ $tag->name }}
								</a>
							@endforeach
							@foreach ($submission->video->tags as $tag)
								<a href="{{ route('browse.by-tag', $tag->slug) }}" class="tag">
									{{ $tag->name }}
								</a>
							@endforeach
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
@endsection
