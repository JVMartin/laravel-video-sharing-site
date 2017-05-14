<div class="column column-block">
	<a class="thumbnail video" href="{{ $submission->url() }}">
		<h2 title="{{ $submission->title }}">{{ $submission->title }}</h2>
		<img src="https://img.youtube.com/vi/{{ $submission->video->youtube_id }}/mqdefault.jpg" />
		<div class="footer">
			<i class="fa fa-comments"></i>
			{{ $submission->num_comments }}
		</div>
	</a>
</div>
