@extends('template')

@section('title', 'Submit Video')

@section('content')
	<section id="videoSubmitGetDetails">
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
						@include('video.partials.embed')
					</div>
				</div>
				<label>
					YouTube Description
				</label>
				<div class="expander">
					<p>{!! nl2br($video->description) !!}</p>
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
						Tags (Please add at least 3)
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
