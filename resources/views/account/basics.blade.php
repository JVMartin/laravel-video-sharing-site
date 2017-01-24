@extends('account.template')

@section('title', 'Basics')

@section('section')
	<h3>
		Username
	</h3>
	<p>
		Must contain only letters, numbers, and dashes.
	</p>
	<div class="row">
		<div class="columns medium-6 end">
			<label for="username">
				Username
				<input type="text" placeholder="Username" name="username" value="{{ old('username', Auth::user()->username) }}">
			</label>
		</div>
	</div>
	<hr />
	<h3>
		Name
	</h3>
	<p>Your name will never appear on the site - it is used only to address you in emails.</p>
	<div class="row">
		<div class="columns medium-6">
			<label for="first_name">
				First Name
				<input type="text" placeholder="First Name" name="first_name" value="{{ old('first_name', Auth::user()->first_name) }}">
			</label>
		</div>
		<div class="columns medium-6">
			<label for="last_name">
				Last Name
				<input type="text" placeholder="Last Name" name="last_name" value="{{ old('last_name', Auth::user()->last_name) }}">
			</label>
		</div>
	</div>
@endsection
