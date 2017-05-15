/**
 * First, load all of our dependencies.
 */

require('./bootstrap');

$(document).foundation();

$('form').submit(function() {
	const $form = $(this);
	const $submitButton = $form.find(':submit').first();

	if ($form.hasClass('form-ajax')) {
		return;
	}

	$submitButton.prop('disabled', true).text('One moment...');
});

//--------------------------------
// Sign in modals
//--------------------------------
(function() {
	const $modalsSignIn = $('#modalsSignIn');
	$modalsSignIn.bind('open.zf.reveal', function() {
		$modalsSignIn.find('input[name="email"]:first').focus();
	});

	const $modalsForgotPassword = $('#modalsForgotPassword');
	$modalsForgotPassword.bind('open.zf.reveal', function() {
		$modalsForgotPassword.find('input[name="email"]').focus();
	});
})();

//--------------------------------
// Tags
//--------------------------------
$('input.tags').selectize({
	delimiter: ',',
	persist: false,
	create: function (input) {
		return {
			value: input,
			text: input
		}
	}
});

$('label.is-invalid-label').find('.selectize-input').focusin(function() {
	$(this).closest('.is-invalid-label').removeClass('is-invalid-label');
});

//--------------------------------
// Expanders
//--------------------------------
// @TODO:
// Perhaps make this so that it doesn't add the button if the .contents div is already smaller
// than 100px.
$('.expander').on('click', '.expand', function() {
	const $expand = $(this);
	const $expander = $expand.closest('.expander');

	const text = $expand.html().trim();

	if (text == 'SHOW MORE') {
		$expander.css({'max-height': 'none'});
		$expand.html('SHOW LESS');
	}
	else {
		$expander.css({'max-height': '100px'});
		$expand.html('SHOW MORE');
	}
});

// Ask for confirmation when necessary.
$('a').click(function(e) {
	let $this = $(this);

	if ($this.attr('data-confirm') && ! confirm($this.data('confirm'))) {
		e.preventDefault();
	}
});

//--------------------------------
// Vue components
//--------------------------------
if ($('comments').length) {
	Vue.component('comments', require('./components/Comments.vue'));
	new Vue({
		el: 'comments'
	});
}
if ($('rating').length) {
	Vue.component('rating', require('./components/Rating.vue'));
	new Vue({
		el: 'rating'
	});
}
if ($('follow-button').length) {
	Vue.component('follow-button', require('./components/FollowButton.vue'));
	new Vue({
		el: 'follow-button'
	});
}
if ($('#usersNotifications').length) {
	require('./notifications');
}
