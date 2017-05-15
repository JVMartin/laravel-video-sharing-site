/**
 * When a user clicks a notification, mark it as read.
 */
$('.notification').mouseup(function() {
	let $this = $(this);
	let hashid = $this.data('hashid');
	$this.find('i').removeClass('fa-circle').addClass('fa-circle-o');
	axios.post('/notifications/read/' + hashid);
});
