@extends('template')

@section('title', $submission->title)

@section('content')
	<section id="videoView">
		<div class="row">
			<div class="column small-12">
				<h1>{{ $submission->title }}</h1>
			</div>
		</div>
		<div class="row">
			<div class="column large-8">
				@include('video._embed', ['video' => $submission->video])
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
					<h4>Submitted By</h4>
					<div class="expander submittedBy">
						<div class="row">
							<div class="column large-9">
								<a href="{{ $submission->user->url() }}">
									<div class="avatarWrap">
										<img src="{{ $submission->user->avatar_url }}" class="avatar" />
									</div>
									<span>
										{{ $submission->user->username }}
									</span>
								</a>
								<div class="date">
									on {{ $submission->created_at->toDayDateTimeString() }}
								</div>
							</div>
							<div class="column large-3">
								<follow-button></follow-button>
							</div>
						</div>
					</div>
				</div>

				<div class="row column">
					<h4>Rating</h4>
					<script>
						var submission = {!! json_encode($submission) !!};
					</script>
					<div class="expander" id="rating">
						<rating></rating>
					</div>
				</div>

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
	</section>
	<section id="comments">
		<comments submission_hashid="{{ $submission->hash }}" parent_comment=""></comments>
	</section>
@endsection
