<template>
	<!-- Scootch over to the right if these are nested comments. -->
	<div :style="(parent_comment) ? 'margin-left: 25px' : ''">
		<h4 v-if=" ! on_profile && loading && ( ! parent_comment || parent_comment.expanded)">
			Loading comments...
		</h4>
		<!-- Always show the comments if this is the submission itself. -->
		<!-- Otherwise, only show the comments if they aren't commenting (replying). -->
		<div class="row column" v-for="comment in comments" v-show=" ! parent_comment || parent_comment.expanded">
			<div class="comment" v-on:click="toggleReplies(comment)" :style="(on_profile || comment.num_replies) ? 'cursor: pointer' : ''">
				<div class="leftPanel">
					<a :href="comment.user.url">
						<img :src="comment.user.avatar_url" v-on:click.stop />
					</a>
					<div class="vote">
						<span :class="'voteButton upvote' + ((comment.user_up) ? ' active' : '')" v-on:click.stop="vote(comment, 1)">
							<i class="fa fa-arrow-up"></i>
							{{ comment.num_up }}
						</span>
					</div>
					<div class="vote">
						<span :class="'voteButton downvote' + ((comment.user_down) ? ' active' : '')" v-on:click.stop="vote(comment, -1)">
							<i class="fa fa-arrow-down"></i>
							{{ -1 * comment.num_down }}
						</span>
					</div>
				</div>
				<div class="rightPanel">
					<div v-html="comment.contents"></div>
					<div class="row">
						<div class="column small-4">
							<div class="details">
								<a class="username" :href="comment.user.url" v-on:click.stop>
									{{ comment.user.username }}
								</a>
								<br />
								<span class="timestamp">
									{{ comment.created_at }}
								</span>
							</div>
						</div>
						<div class="column small-8 text-right">
							<span class="numReplies" v-if="comment.num_replies">
								<span v-if=" ! on_profile">
									<i class="fa fa-chevron-up" v-if=" ! comment.expanded"></i>
									<i class="fa fa-chevron-down" v-if="comment.expanded"></i>
								</span>
								<span v-if=" ! comment.expanded">
									{{ comment.num_replies }} {{ (comment.num_replies == 1) ? 'Reply' : 'Replies' }}
								</span>
							</span>
						</div>
					</div>
					<div class="reply" v-if=" ! on_profile" v-on:click.stop="replyTo(comment)">
						Reply
					</div>
				</div>
				<div class="clear"></div>
			</div>

			<comments
				:submission_hashid="submission_hashid"
				:parent_comment="comment"
				v-if=" ! on_profile && comment.componentLoaded"
			    v-on:newReply="handleNewReply(comment)"
			></comments>
		</div>

		<div class="row column large-8" v-if=" ! on_profile" v-show=" ! parent_comment || parent_comment.replying">
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

	const user_comments = window.user_comments;

	export default {
		props: [
			// The hashid of the submission being watched.
			'submission_hashid',

			// The comment being replied to, or null if this is the root (submission) comments.
			'parent_comment',
		],

		data() {
			return {
				// The signed-in user.
				user: window.data.user,

				// The list of comments.
				comments: [],

				loading: true,

				// Are we on a user's profile instead of a submission?
				on_profile: false,
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

			// If we're on a user's profile page viewing their comments.
			if (user_comments) {
				this.on_profile = true;
				this.comments = user_comments;
			}
			// If we're on a submission.
			else {
				axios.get(this.commentRoute).then(function(response) {
					let comments = response.data;

					_.forEach(comments, function(comment) {
						self.initComment(comment);
					});

					self.comments = response.data;
					self.loading = false;
				});

				let tConfig = tinymceConfig();
				tConfig.selector = '#' + this.wysiwygId;
				tinymce.init(tConfig);
				tinymce.execCommand('mceFocus', false, this.wysiwygId);
			}
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
			 * Vote on a comment.
			 *
			 * @param comment
			 * @param value
			 */
			vote(comment, value) {
				// They must be signed in.
				if ( ! this.user) {
					$('#modalsSignIn').foundation('open');
					return;
				}

				// If we're on a user's profile, just send them to the submission.
				if (this.on_profile) {
					window.location = comment.submission.url;
					return;
				}

				if (value == 1) {
					// You already voted up, ya dingus.
					if (comment.user_up) return;

					if (comment.user_down) {
						comment.user_down = false;
						comment.num_down--;
					}
					comment.user_up = true;
					comment.num_up++;
				}
				else {
					// You already voted down, ya dingus.
					if (comment.user_down) return;

					if (comment.user_up) {
						comment.user_up = false;
						comment.num_up--;
					}
					comment.user_down = true;
					comment.num_down++;
				}

				axios.post('/comments/vote/' + comment.hash, {
					value: value,
				}).then(function(response) {
					//
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
				// If we're on a user's profile, just send them to the submission.
				if (this.on_profile) {
					window.location = comment.submission.url;
					return;
				}

				// No need to do anything if there are no replies.
				if (comment.num_replies == 0) {
					return;
				}

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
				// They must be signed in.
				if ( ! this.user) {
					$('#modalsSignIn').foundation('open');
					return;
				}

				comment.componentLoaded = true;

				comment.expanded = false;
				comment.replying = true;
			},
		},
	};
</script>
