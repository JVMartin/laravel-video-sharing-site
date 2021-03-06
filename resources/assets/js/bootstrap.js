// Window-bound objects.
window._ = require('lodash');
window.$ = window.jQuery = require('jquery');
window.Vue = require('vue');
window.tinymce = require('tinymce/tinymce');
window.axios = require('axios');
window.axios.defaults.headers.common = {
	'X-CSRF-TOKEN': window.data.csrfToken,
	'X-Requested-With': 'XMLHttpRequest'
};

// External packages - order matters.
require('foundation-sites');
require('selectize');

// My scripts
require('./form-ajax');
require('./wysiwyg');

/**
 * Echo exposes an expressive API for subscribing to channels and listening
 * for events that are broadcast by Laravel. Echo and event broadcasting
 * allows your team to easily build robust real-time web applications.
 */

// import Echo from "laravel-echo"

// window.Echo = new Echo({
//     broadcaster: 'pusher',
//     key: 'your-pusher-key'
// });
