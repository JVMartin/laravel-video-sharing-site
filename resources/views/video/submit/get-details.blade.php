@extends('template')

@section('title', 'Submit Video')

@section('content')
	<section id="videoSubmitGetDetails">
		<div class="row">
			<div class="column small-12">
				<h1>Submit Video</h1>
				<p>Tell us more about the video.</p>
			</div>
		</div>
		<div class="row">
			<div class="columns large-5 large-push-7">
				<div class="row">
					<div class="columns medium-7 large-12">
						<h4>Video</h4>
						@include('video._embed')
					</div>
				</div>
				<h4>Youtube Description</h4>
				<div class="expander">
					<div class="contents">
						{!! nl2br($video->description) !!}
					</div>
					<div class="expand">SHOW MORE</div>
				</div>
			</div>
			<div class="columns large-7 large-pull-5">
				<form action="{{ route('video.submit.details.process', $video->hash) }}" method="POST" autocomplete="off">
					{!! csrf_field() !!}
					<label for="title" class="{{ ($errors->has('title')) ? 'is-invalid-label' : '' }}">
						Your Title
						<input type="text" placeholder="Title" name="title" value="{{ old('title') }}" class="{{ ($errors->has('title')) ? 'is-invalid-input' : '' }}" required autofocus>
						@foreach ($errors->get('title') as $error)
							<span class="form-error is-visible">
				        {!! $error !!}
			        </span>
						@endforeach
					</label>
					<label for="tags" class="{{ ($errors->has('tags')) ? 'is-invalid-label' : '' }}">
						Tags (Optional, separate with commas or tabs)
						<input type="text" name="tags" value="{{ old('tags') }}" class="tags">
						@foreach ($errors->get('tags') as $error)
							<span class="form-error is-visible">
				        {!! $error !!}
			        </span>
						@endforeach
					</label>
					<label>
						Your Description (Optional)
						<textarea class="tinymce" name="description">{{ old('description') }}</textarea>
					</label>
					<p></p>
					<button type="submit" class="button">
						Submit Video
					</button>
				</form>
			</div>
		</div>
	</section>
@endsection
