<template>
	<section id="comments">
		<div class="row column" v-for="comment in comments">
			<div v-html="comment.contents"></div>
		</div>
		<div class="row column large-8">
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
	const data = window.data;

	function wysiwyg(selector) {
		let config = require('../tinymce-config');
		config.selector = selector;
		tinymce.init(config);
	}

	export default {
		props: ['hashid'],
		data() {
			return {
				data: data,
				comments: [],
			};
		},
		mounted() {
			let self = this;
			axios.get('/comments/submission/' + this.hashid).then(function(response) {
				self.comments = response.data;
			});
//			this.$http.get('/comments/submission/' + window.data.submissionHash).then(response => {
//				console.log(response);
//				this.comments = response.body;
//			}, response => {
//
//			});
			wysiwyg('#commentBox');
		},
		methods: {
			submitComment() {
				let comment = tinymce.get('commentBox').getContent();
				axios.post('/comments/submission/' + this.hashid, {
					comment: comment,
				});

				this.comments.push({
					contents: comment,
				});
			},
		},
	};
</script>

<style lang="scss" rel="stylesheet/scss">
	.postCommentWrap {
		margin-top: 15px;
	}
</style>
