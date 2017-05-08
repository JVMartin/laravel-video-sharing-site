@extends('template')

@section('title', 'Site')

@section('content')
	@include('users._header')

	<div class="row column text-center">
		{{ $comments->links('pagination::foundation') }}
	</div>
@endsection
