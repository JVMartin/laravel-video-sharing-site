@extends('template')

@section('title', 'Site')

@section('content')
	<section id="videoBrowse">
		<div class="row">
			<div class="column small-12">
				<h1>Video Sharing Site</h1>
			</div>
		</div>
		<div class="row small-up-1 medium-up-2 large-up-3">
			@foreach ($submissions as $submission)
				<div class="thumbnail">
					<h3>{{ $submission->title }}</h3>
					<img src="https://img.youtube.com/vi/{{ $submission->video->youtube_id }}/mqdefault.jpg" />
				</div>
			@endforeach
		</div>
	</section>
@endsection
