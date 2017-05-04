<template>
	<div>
		<div class="row column" v-for="comment in comments">
			<div class="comment">
				<a class="avatar">
					<img :src="comment.user.avatar_url" />
				</a>
				<div v-html="comment.contents"></div>
				<div class="row">
					<div class="column small-9">
						<div class="details">
							<span class="username">
								{{ comment.user.username }}
							</span>
							<br />
							<span class="timestamp">
								{{ comment.created_at }}
							</span>
						</div>
					</div>
					<div class="column small-3 text-right">
						<span class="fakelink" v-on:click="expand(comment)">
							Replies (0)
						</span>
					</div>
				</div>
			</div>

			<comments :hashid="hashid" :parent_hash="comment.hash" v-if="expanding == comment.hash"></comments>
		</div>

		<div class="row column large-8" v-if=" ! parent_id && ! commentSubmitted">
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
	</div>
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
		props: [
			// The hashid of the submission being watched.
			'submission_hash',

			// The hashed parent_id of the comment being replied to.
			'parent_hash'
		],

		data() {
			return {
				// Data passed in from Laravel.
				data: data,

				// The list of comments.
				comments: [],

				// Has a comment been submitted?
				commentSubmitted: false,

				// The hashid of the comment being expanded.
				expanding: null,
			};
		},

		mounted() {
			let self = this;

			axios.get('/comments/submission/' + this.submission_hash + '/' + this.parent_hash).then(function(response) {
				let comments = response.data;
				_.forEach(comments, function(comment) {
					comment.comments = [];
				});
				self.comments = response.data;
			});

			wysiwyg('#commentBox');
		},

		methods: {
			/**
			 * Submitting a comment.
			 */
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

			expand(comment) {
				this.expanding = comment.hash;
			},
		},
	};
</script>
