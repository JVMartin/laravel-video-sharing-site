@extends('template')

@section('title', 'Videos')

@section('content')
	<section id="videoSubmit">
		<div class="row">
			<div class="column small-12">
				<h1>Submit Video</h1>
				<p>Next, tell us more about the video.</p>
			</div>
		</div>
		<div class="row">
			<div class="columns large-5 large-push-7">
				<div class="row">
					<div class="columns medium-7 large-12">
						<label>
							Video
						</label>
						@include('video.embed')
						<label>
							Youtube Description
						</label>
						<p>
							{!! nl2br($video->description) !!}
						</p>
					</div>
				</div>
			</div>
			<div class="columns large-7 large-pull-5">
				<label for="title" class="{{ ($errors->has('title')) ? 'is-invalid-label' : '' }}">
					Your Title
					<input type="text" placeholder="Title" name="title" value="{{ old('title') }}" class="{{ ($errors->has('title')) ? 'is-invalid-input' : '' }}" required autofocus>
					@foreach ($errors->get('title') as $error)
						<span class="form-error is-visible">
			        {!! $error !!}
		        </span>
					@endforeach
				</label>
				<label>
					Your Description (Optional)
					<textarea class="tinymce" name="description">{{ old('description') }}</textarea>
				</label>
			</div>
		</div>
	</section>
@endsection
