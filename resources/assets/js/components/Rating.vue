<template>
	<div>
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
</template>

<script>

</script>
