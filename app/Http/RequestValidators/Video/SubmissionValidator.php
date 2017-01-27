<?php

namespace App\Http\RequestValidators\Video;

use Illuminate\Http\Request;
use App\Http\RequestValidators\RequestValidator;

class SubmissionValidator extends RequestValidator
{
    /**
     * Perform validation.
     *
     * @param Request $request - The request to validate.
     */
    public function validateRequest(Request $request)
    {
        $validator = $this->getValidationFactory()->make($request->all(), [
            'youtube_url' => 'required',
        ]);

        // Custom validation to ensure that the role is acceptable.
        $validator->after(function ($validator) use ($request) {
        });

        if ($validator->fails()) {
            $this->throwValidationException($request, $validator);
        }
    }
}
