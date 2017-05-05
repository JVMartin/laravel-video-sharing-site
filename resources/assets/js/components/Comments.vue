<template>
	<!-- Scootch over to the right if these are nested comments. -->
	<div :style="(parent_comment) ? 'margin-left: 25px' : ''">
		<!-- Always show the comments if this is the submission itself. -->
		<!-- Otherwise, only show the comments if they aren't commenting (replying). -->
		<div class="row column" v-for="comment in comments" v-show=" ! parent_comment || parent_comment.expanded">
			<div class="comment" v-on:click="toggleReplies(comment)" :style="(comment.num_replies) ? 'cursor: pointer' : ''">
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
				:parent_comment="comment"
				v-if="comment.componentLoaded"
			    v-on:newReply="handleNewReply(comment)"
			></comments>
		</div>

		<div class="row column large-8" v-show=" ! parent_comment || parent_comment.replying">
			<h4 v-if="parent_comment">Reply to {{ parent_comment.user.username }}</h4>
			<h4 v-else>Leave a comment</h4>
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

			// The comment being replied to, or null if this is the root (submission) comments.
			'parent_comment'
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
				return (this.parent_comment) ? 'reply' : 'comment';
			},

			commentRoute() {
				let route = '/comments/submission/' + this.submission_hashid;

				if (this.parent_comment) {
					route += '/' + this.parent_comment.hash;
				}

				return route;
			},

			wysiwygId() {
				let id = 'wysiwyg';
				if (this.parent_comment) {
					id += '-' + this.parent_comment.hash;
				}
				return id;
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
			tinymce.execCommand('mceFocus', false, this.wysiwygId);
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

				tinymce.get(this.wysiwygId).setContent('');

				axios.post(this.commentRoute, {
					comment: comment,
				}).then(function(response) {
					let comment = response.data;
					self.initComment(comment);
					self.comments.push(comment);
					self.$emit('newReply');
				});
			},

			/**
			 * Handle a new reply propagating up from the nested reply field.
			 *
			 * @param comment - The comment being replied to.
			 */
			handleNewReply(comment) {
				comment.num_replies++;
				comment.replying = false;
				comment.expanded = true;
			},

			/**
			 * Add extra data to the comment just for usage in this Vue component.
			 *
			 * @param comment
			 */
			initComment(comment) {
				comment.componentLoaded = false;
				comment.expanded = false;
				comment.replying = false;
			},

			/**
			 * Expand or unexpand a given comment's replies.
			 *
			 * @param comment
			 */
			toggleReplies(comment) {
				comment.componentLoaded = true;

				if (comment.expanded) {
					comment.expanded = false;
				}
				else {
					comment.expanded = true;

					// We also need to hide the reply box.
					comment.replying = false;
				}
			},

			/**
			 * Reply to a given comment.
			 *
			 * @param comment
			 */
			replyTo(comment) {
				comment.componentLoaded = true;

				comment.expanded = false;
				comment.replying = true;
			},
		},
	};
</script>
