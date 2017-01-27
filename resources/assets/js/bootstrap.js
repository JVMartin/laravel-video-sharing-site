// Window-bound objects.
window._ = require('lodash');
window.$ = window.jQuery = require('jquery');
window.Vue = require('vue');
window.tinymce = require('tinymce/tinymce');

// External packages - order matters.
require('vue-resource');
require('foundation-sites');
require('tinymce/themes/modern/theme');
require('tinymce/plugins/code');
require('tinymce/plugins/image');
require('tinymce/plugins/link');
require('tinymce/plugins/autoresize');

// My scripts
require('./form-ajax');

/**
 * We'll register a HTTP interceptor to attach the "CSRF" header to each of
 * the outgoing requests issued by this application. The CSRF middleware
 * included with Laravel will automatically verify the header's value.
 */

Vue.http.interceptors.push((request, next) => {
	request.headers.set('X-CSRF-TOKEN', Laravel.csrfToken);

	next();
});

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
