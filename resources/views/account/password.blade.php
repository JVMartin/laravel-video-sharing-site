@extends('account.template')

@section('title', 'Password')

@section('section')
	<h3>
		Change Password
	</h3>
	<div class="row">
		<div class="columns medium-6 end">
			<label for="password">
				Password
				<input type="password" name="password" placeholder="Password" autofocus>
			</label>
			<label for="password_confirmation">
				Confirm Password
				<input type="password" name="password_confirmation" placeholder="Confirm Password">
			</label>
		</div>
	</div>
@endsection
