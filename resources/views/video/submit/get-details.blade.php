@extends('template')

@section('title', 'Videos')

@section('content')
	<section id="videoSubmit">
		<div class="row">
			<div class="column small-12">
				<h1>Submit Video</h1>
			</div>
		</div>
		<div class="row">
			<div class="columns medium-6 end">
				<label>
					Video
				</label>
				@include('video.embed')
				<label for="title" class="{{ ($errors->has('title')) ? 'is-invalid-label' : '' }}">
					Your Title
					<input type="text" placeholder="Title" name="title" value="{{ old('title') }}" class="{{ ($errors->has('title')) ? 'is-invalid-input' : '' }}" required>
					@foreach ($errors->get('title') as $error)
						<span class="form-error is-visible">
			        {!! $error !!}
		        </span>
					@endforeach
				</label>
			</div>
		</div>
		<div class="row">
			<div class="columns small-12">
				<label>
					Your Description (Optional)
					<textarea class="tinymce" name="description">{{ old('description') }}</textarea>
				</label>
			</div>
		</div>
	</section>
@endsection
