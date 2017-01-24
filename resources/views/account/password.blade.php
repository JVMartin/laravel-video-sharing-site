@extends('account.template')

@section('title', 'Password')

@section('section')
	<div class="row">
		<div class="column small-12">
			<h3>
				Change Password
			</h3>
			<div class="row">
				<div class="columns medium-6">
					<label for="password">
						<input type="password" name="password">
					</label>
				</div>
				<div class="columns medium-6">
					<label for="password_confirmation">
						<input type="password" name="password_confirmation">
					</label>
				</div>
			</div>
		</div>
	</div>
@endsection
