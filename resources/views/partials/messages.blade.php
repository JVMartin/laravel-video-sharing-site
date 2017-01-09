<section id="partialsMessages">
	@foreach ($errors->getBag('default')->get('messages') as $message)
		<div class="row">
			<div class="columns small-12">
				<div class="callout alert">
					{{ $message }}
				</div>
			</div>
		</div>
	@endforeach
	@foreach ($successes->all() as $message)
		<div class="row">
			<div class="columns small-12">
				<div class="callout success">
					{{ $message }}
				</div>
			</div>
		</div>
	@endforeach
</section>
