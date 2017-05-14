<div class="column column-block">
	<a class="thumbnail video" href="{{ $submission->url() }}">
		<h2 title="{{ $submission->title }}">{{ $submission->title }}</h2>
		<img src="https://img.youtube.com/vi/{{ $submission->video->youtube_id }}/mqdefault.jpg" />
		<div class="footer">
			<div class="row">
				<div class="column small-4">
					<div class="commentCountWrap">
						<i class="fa fa-comments"></i>
						{{ $submission->num_comments }}
					</div>
				</div>
				<div class="column small-6">
					<div class="ratingWrap">
						<div class="rating">
							<div class="bar" style="width: {{ $submission->ratingPercent() }}%"></div>
							<div class="labels">
								<div class="up">
									{{ $submission->num_up }}
								</div>
								<div class="down">
									{{ -1 * $submission->num_down }}
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</a>
</div>
