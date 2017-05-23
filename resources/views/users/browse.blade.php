@extends('template')

@section('title', $user->username . '\'s Submissions')

@section('content')
	@include('users._header')
	<section id="videoBrowse">
		@if ( ! $submissions->count())
			<div class="row column">
				<div class="callout secondary">
					This user has made no submissions.
				</div>
			</div>
		@endif
		<div class="row small-up-2 medium-up-3 large-up-4">
			@foreach ($submissions as $submission)
				@include('video._submission-thumb')
			@endforeach
		</div>
		<div class="row column text-center">
			{{ $submissions->links('pagination::foundation') }}
		</div>
	</section>
@endsection
