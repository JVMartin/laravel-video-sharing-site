@extends('template')

@section('title', 'Site')

@section('content')
	@include('users._header')

	<script>
		window.user_comments = {!! json_encode($comments->all()) !!};
	</script>

	<section id="comments">
		<comments></comments>
	</section>

	<div class="row column text-center">
		{{ $comments->links('pagination::foundation') }}
	</div>
@endsection
