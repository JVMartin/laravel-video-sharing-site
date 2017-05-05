<template>
	<!-- Scootch over to the right if these are nested comments. -->
	<div :style="(parent_hashid) ? 'margin-left: 25px' : ''">
		<!-- Always show the comments if this is the submission itself. -->
		<!-- Otherwise, only show the comments if they aren't commenting (replying). -->
		<div class="row column" v-for="comment in comments" v-if=" ! parent_hashid || ! commenting">
			<div class="comment" v-on:click="toggleReplies(comment)">
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
						<span class="replies" v-if="comment.num_replies">
							<i class="fa fa-chevron-up" v-if=" ! comment.expanded"></i>
							<i class="fa fa-chevron-down" v-if="comment.expanded"></i>
							<span v-if=" ! comment.expanded">
								{{ comment.num_replies }} Replies
							</span>
						</span>
					</div>
				</div>
				<div class="reply" v-on:click.stop="replyTo(comment)">
					Reply
				</div>
			</div>

			<comments
				:submission_hashid="submission_hashid"
				:parent_hashid="comment.hash"
				:commenting="comment.replying"
				v-if="comment.expanded || comment.replying"
			    v-on:newReply="handleNewReply(comment)"
			></comments>
		</div>

		<div class="row column large-8" v-show="commenting">
			<h4>Leave a {{ action }}</h4>
			<div v-if="data.user">
				<textarea :id="wysiwygId"></textarea>
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
			'parent_hashid',

			'commenting'
		],

		data() {
			return {
				// Data passed in from Laravel.
				data: data,

				// The list of comments.
				comments: [],
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

			wysiwygId() {
				return 'wysiwyg' + this.parent_hashid;
			}
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

			let tConfig = tinymceConfig();
			tConfig.selector = '#' + this.wysiwygId;
			tinymce.init(tConfig);
		},

		methods: {
			/**
			 * Submitting a comment.
			 */
			submitComment() {
				let self = this;
				let comment = tinymce.get(this.wysiwygId).getContent();

				if ( ! comment.length) {
					alert('You gotta say something first!');
					return;
				}

				this.commenting = false;

				axios.post(this.commentRoute, {
					comment: comment,
				}).then(function(response) {
					let comment = response.data;
					self.initComment(comment);
					self.comments.push(comment);
					self.$emit('newReply');
				});
			},

			handleNewReply(comment) {
				comment.num_replies++;
				comment.replying = false;
				comment.expanded = true;
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

			/**
			 * Expand or unexpand the comment's replies.
			 *
			 * @param comment
			 */
			toggleReplies(comment) {
				if (comment.expanded) {
					comment.expanded = false;
				}
				else {
					comment.expanded = true;

					// We also need to hide the reply box.
					comment.replying = false;
				}
			},

			replyTo(comment) {
				comment.expanded = false;
				comment.replying = true;
			},
		},
	};
</script>
