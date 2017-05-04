<template>
	<section id="comments">
		<div class="row column" v-for="comment in comments">
			<div class="comment">
				<div v-html="comment.contents"></div>
				<div class="timestamp">
					On {{ comment.created_at }}
				</div>
			</div>
		</div>
		<div class="row column large-8" v-if=" ! commentSubmitted">
			<h4>Leave a comment</h4>
			<div v-if="data.auth">
				<textarea id="commentBox"></textarea>
				<div class="row column text-right postCommentWrap">
					<button type="submit" class="button" v-on:click="submitComment">
						Post comment
					</button>
				</div>
			</div>
			<button v-else class="button" data-open="modalsSignIn">
				Sign in to leave a comment
			</button>
		</div>
	</section>
</template>

<script>
	import tinymceConfig from '../tinymce-config';

	const data = window.data;

	function wysiwyg(selector) {
		let config = tinymceConfig();
		config.selector = selector;
		tinymce.init(config);
	}

	export default {
		props: ['hashid'],
		data() {
			return {
				data: data,
				comments: [],
				commentSubmitted: false,
			};
		},
		mounted() {
			let self = this;

			axios.get('/comments/submission/' + this.hashid).then(function(response) {
				self.comments = response.data;
			});

			wysiwyg('#commentBox');
		},
		methods: {
			submitComment() {
				let comment = tinymce.get('commentBox').getContent();
				let self = this;

				if ( ! comment.length) {
					alert('You gotta say something first!');
					return;
				}

				this.commentSubmitted = true;

				axios.post('/comments/submission/' + this.hashid, {
					comment: comment,
				}).then(function(response) {
					self.comments.push(response.data);
				});
			},
		},
	};
</script>
