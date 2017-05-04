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

			<comments :submission_hash="submission_hash" :parent_hash="comment.hash" v-if="expanding == comment.hash"></comments>
		</div>

		<div class="row column large-8" v-if=" ! commentSubmitted">
			<h4>Leave a {{ action }}</h4>
			<div v-if="data.auth">
				<textarea class="tinymce"></textarea>
				<div class="row column text-right postCommentWrap">
					<button type="submit" class="button" v-on:click="submitComment">
						Post {{ action }}
					</button>
				</div>
			</div>
			<button v-else class="button" data-open="modalsSignIn">
				Sign in to leave a {{ action }}
			</button>
		</div>
	</div>
</template>

<script>
	import tinymceConfig from '../tinymce-config';

	const data = window.data;

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

		computed: {
			action() {
				return (this.parent_hash) ? 'reply': 'comment';
			},
		},

		mounted() {
			let self = this;

			axios.get('/comments/submission/' + this.submission_hash + '/' + this.parent_hash).then(function(response) {
				self.comments = response.data;
			});

			tinymce.init(tinymceConfig());
		},

		methods: {
			/**
			 * Submitting a comment.
			 */
			submitComment() {
				let self = this;
				let comment = tinymce.activeEditor.getContent();

				if ( ! comment.length) {
					alert('You gotta say something first!');
					return;
				}

				this.commentSubmitted = true;

				axios.post('/comments/submission/' + this.submission_hash + '/' + this.parent_hash, {
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
