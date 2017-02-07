<?php

namespace App\Http\RequestValidators;

use Illuminate\Http\Request;

class VideoSubmissionDetailsValidator extends RequestValidator
{
	/**
	 * Perform validation.
	 *
	 * @param Request $request - The request to validate.
	 */
	public function validateRequest(Request $request)
	{
		$validator = $this->getValidationFactory()->make($request->all(), [
			'title' => 'required|min:3',
			'tags' => 'required'
		]);

		// Enforce minimum number of tags.
		$validator->after(function ($validator) use ($request) {
			$numTags = count(explode(',', $request->tags));
			if ($numTags < 3) {
				$validator->errors()->add('tags', 'Please add at least 3 tags.');
			}
		});

		if ($validator->fails()) {
			$this->throwValidationException($request, $validator);
		}
	}
}
