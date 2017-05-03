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
				@if (strlen($submission->description))
					<div class="row">
						<div class="column small-12">
							{!! $submission->description !!}
						</div>
					</div>
				@endif
			</div>
			<div class="column large-4">
				<div class="row column">
					<h4>Tags</h4>
					<div class="expander">
						<div class="contents">
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
						<div class="expand">SHOW MORE</div>
					</div>
				</div>
				<div class="row column">
					<h4>Youtube Description</h4>
					<div class="expander">
						<div class="contents">
							{!! nl2br($submission->video->description) !!}
						</div>
						<div class="expand">SHOW MORE</div>
					</div>
				</div>
			</div>
		</div>
		<comments hashid="{{ $submission->hash }}"></comments>
	</section>
@endsection
