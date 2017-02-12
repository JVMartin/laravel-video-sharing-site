@extends('account.template')

@section('title', 'Picture')

@section('section')
	<form action="{{ route('account.basics.process') }}" method="POST" enctype="multipart/form-data">
		{!! csrf_field() !!}
		<h3>Picture</h3>
		<div class="row">
			<div class="columns medium-6 end">
				<label for="username" class="{{ ($errors->has('username')) ? 'is-invalid-label' : '' }}">
					Select Picture
					<input type="file" placeholder="Picture" name="picture" class="{{ ($errors->has('picture')) ? 'is-invalid-input' : '' }}" required>
					@foreach ($errors->get('picture') as $error)
		        <span class="form-error is-visible">
			        {!! $error !!}
		        </span>
		      @endforeach
				</label>
			</div>
		</div>
		<hr />
		<button type="submit" class="button">
			Save
		</button>
	</form>
@endsection
