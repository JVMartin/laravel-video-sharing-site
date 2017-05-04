@extends('account.template')

@section('title', 'Picture')

@section('section')
	<section id="accountPicture">
		<h3>Picture</h3>
		<div class="picture-frame">
			@if (Auth::user()->has_avatar)
				<a href="{{ route('account.picture.delete') }}"
				   class="button tiny"
				   data-confirm="Are you sure you want to delete your current picture?">
						<i class="fa fa-trash"></i>
				</a>
			@endif
			<img src="{{ Auth::user()->avatar_url }}" />
		</div>
		<p>
			Upload a picture to be displayed alongside your username.
			It will be cropped to a square for you.
		</p>
		<form action="{{ route('account.picture.process') }}" method="POST" enctype="multipart/form-data" autocomplete="off">
			{!! csrf_field() !!}
			<div class="row">
				<div class="columns medium-6 end">
					<label for="picture" class="{{ ($errors->has('picture')) ? 'is-invalid-label' : '' }}">
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
				Upload Picture
			</button>
		</form>
	</section>
@endsection
