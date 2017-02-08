@extends('template')

@section('title', $submission->title)

@section('content')
	<section id="videoView">
		<div class="row">
			<div class="column small-12">
				<h1>{{ $submission->title }}</h1>
				@include('video.partials.embed')
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
					<p>{!! nl2br($video->description) !!}</p>
				</div>
			</div>
		</div>
	</section>
@endsection
