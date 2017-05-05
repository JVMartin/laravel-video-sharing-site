<template>
	<!-- Scootch over to the right if these are nested comments. -->
	<div :style="(parent_hashid) ? 'margin-left: 25px' : ''">
		<div class="row column" v-for="comment in comments">
			<div class="comment" v-on:click="expandToggle(comment)">
				<a class="avatar">
					<img :src="comment.user.avatar_url" />
				</a>
				<div v-html="comment.contents"></div>

				<div class="row">
					<div class="column small-4">
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
					<div class="column small-8 text-right">
						<span class="fakelink reply" v-on:click="replyTo(comment)">
							Reply
						</span>
						<span class="replies">
							<i class="fa fa-chevron-up" v-if=" ! comment.expanded"></i>
							<i class="fa fa-chevron-down" v-if="comment.expanded"></i>
							{{ comment.num_replies }} Replies
						</span>
					</div>
				</div>
				<div class="reply" v-on:click="replyTo(comment)">
					Reply
				</div>
			</div>

			<comments
				:submission_hashid="submission_hashid"
				:parent_hashid="comment.hash"
				v-if="comment.expanded"
			    v-on:newcomment="comment.num_replies++"
			></comments>
		</div>

		<div class="row column large-8" v-if=" ! parent_hashid && ! commentSubmitted">
			<h4>Leave a {{ action }}</h4>
			<div v-if="data.user">
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
			'submission_hashid',

			// The hashed parent_id of the comment being replied to.
			'parent_hashid'
		],

		data() {
			return {
				// Data passed in from Laravel.
				data: data,

				// The list of comments.
				comments: [],

				// Has a comment been submitted at this level?
				commentSubmitted: false,
			};
		},

		computed: {
			action() {
				return (this.parent_hashid) ? 'reply' : 'comment';
			},

			commentRoute() {
				let route = '/comments/submission/' + this.submission_hashid;

				if (this.parent_hashid) {
					route += '/' + this.parent_hashid;
				}

				return route;
			},
		},

		mounted() {
			let self = this;

			axios.get(this.commentRoute).then(function(response) {
				let comments = response.data;

				_.forEach(comments, function(comment) {
					self.initComment(comment);
				});

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

				axios.post(this.commentRoute, {
					comment: comment,
				}).then(function(response) {
					let comment = response.data;
					self.initComment(comment);
					self.comments.push(comment);
					self.$emit('newcomment');
				});
			},

			/**
			 * Add extra data to the column for usage in the Vue component.
			 *
			 * @param comment
			 */
			initComment(comment) {
				comment.expanded = false;
				comment.replying = false;
			},

			expandToggle(comment) {
				comment.expanded = ! comment.expanded;
			},
		},
	};
</script>
