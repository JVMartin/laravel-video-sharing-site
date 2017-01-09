/**
 * Plumbing for AJAX forms.
 */

$('.form-ajax').submit(function(e) {
	e.preventDefault();

	// Gather initial state.
	const $form = $(this);
	const $submitButton = $form.find(':submit');
	const origText = $submitButton.text().trim();
	const ajaxText = $submitButton.data('ajax');
	$submitButton.text(ajaxText).prop('disabled', true);

	// Reset/remove the old errors.
	$form.find('.is-invalid-label').removeClass('is-invalid-label');
	$form.find('.is-invalid-input').removeClass('is-invalid-input');
	$form.find('.form-error').remove();
	$form.find('.callout.alert').remove();

	function addError(error) {
		$form.prepend('<div class="callout alert">' + error + '</div>');
	}

	$.post($form.attr('action'), $form.serialize(), function(data) {
		console.log('success');
		console.log(data);
	}).fail(function(data) {
		// Throttle lockout
		if (data.status === 429) {
			const seconds = data.getResponseHeader('Retry-After');
			let error = 'You have tried too many times.';
			if (seconds) {
				error += ' You may try again in ' + seconds + ' seconds.';
			}
			addError(error);
		}
		// Form validation errors
		else if (data.status === 422) {
			const errors = data.responseJSON;
			_.each(errors, function(errors, column) {
				const $label = $form.find('label[for="' + column + '"]');
				const $input = $label.children().first();
				$label.addClass('is-invalid-label');
				$input.addClass('is-invalid-input');
				_.each(errors, function(error) {
					$input.after('<span class="form-error is-visible">' + error + '</span>');
				});
			});
		}
		// Other errors
		else {
			addError('There was an error connecting to the server.');
			console.log(data);
		}

		$submitButton.text(origText).prop('disabled', false);
	});
});
