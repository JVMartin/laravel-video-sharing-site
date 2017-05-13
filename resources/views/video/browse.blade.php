@extends('template')

@section('title', 'Site')

@section('content')
	<section id="videoBrowse">
		@if (isset($tag))
			<div class="row column">
				<h4>Showing videos tagged "{{ $tag->name }}"...</h4>
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
