@if ($video->embeddable)
	<div class="responsive-embed">
		<iframe width="560" height="315" src="https://www.youtube.com/embed/{{ $video->youtube_id }}" frameborder="0" allowfullscreen></iframe>
	</div>
@else
	<a href="https://www.youtube.com/watch?v={{ $video->youtube_id }}" target="_blank">
		<img src="https://img.youtube.com/vi/{{ $video->youtube_id }}/mqdefault.jpg" />
	</a>
@endif