@extends('template')

@section('title', 'Site')

@section('content')
	@include('users._header')

	@if ( ! $comments->count())
		<div class="row column">
			<div class="callout secondary">
				This user has made no comments.
			</div>
		</div>
	@endif

	<script>
		var user_comments = {!! json_encode($comments->all()) !!};
	</script>

	<section id="comments">
		<comments></comments>
	</section>

	<div class="row column text-center">
		{{ $comments->links('pagination::foundation') }}
	</div>
@endsection
