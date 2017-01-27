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
				<label for="youtube_url" class="{{ ($errors->has('youtube_url')) ? 'is-invalid-label' : '' }}">
					Youtube URL
					<input type="text" placeholder="Youtube URL" name="youtube_url" value="{{ old('youtube_url') }}" class="{{ ($errors->has('youtube_url')) ? 'is-invalid-input' : '' }}" autofocus required>
					@foreach ($errors->get('youtube_url') as $error)
		        <span class="form-error is-visible">
			        {!! $error !!}
		        </span>
		      @endforeach
				</label>
				<label for="title" class="{{ ($errors->has('title')) ? 'is-invalid-label' : '' }}">
					Title
					<input type="text" placeholder="Title" name="title" value="{{ old('title') }}" class="{{ ($errors->has('title')) ? 'is-invalid-input' : '' }}" required>
					@foreach ($errors->get('title') as $error)
						<span class="form-error is-visible">
			        {!! $error !!}
		        </span>
					@endforeach
				</label>
			</div>
		</div>
	</section>
@endsection
