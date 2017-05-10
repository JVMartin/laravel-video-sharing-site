<section id="partialsMessages">
	@foreach ($errors->getBag('default')->get('messages') as $message)
		<div class="row column">
			<div class="callout alert" data-closable>
				{{ $message }}
				<button class="close-button" aria-label="Dismiss alert" type="button" data-close>
					<i class="fa fa-close"></i>
				</button>
			</div>
		</div>
	@endforeach
	@foreach ($successes->get('messages') as $message)
		<div class="row column">
			<div class="callout success" data-closable>
				{{ $message }}
				<button class="close-button" aria-label="Dismiss alert" type="button" data-close>
					<i class="fa fa-close"></i>
				</button>
			</div>
		</div>
	@endforeach
</section>
