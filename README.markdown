# Unobtrusive flash messages for Rails

**Version 1 users:** this gem got a major redesign in version 2, please read the documentation

Ever got tired of pages that can't be cached because they contain flash messages?

Ever got tired of writing custom code to handle flash messages passed in AJAX responses?

Here comes the solution.

`unobtrusive_flash` takes your flash messages for the backend and automagically passes them to the frontend via
HTTP cookies. This works with both regular page loads and AJAX requests, does not tamper with the page body and requires
about 3 extra lines of code in your app - how's that for unobtrusive?

You can pass up to 4K of text into flash this way, and you don't need to worry about cookie size since they are
cleared immediately upon rendering.

Tested in: 

* Internet Explorer 8 and later
* Firefox up to v24
* Chrome up to v30
* Safari 6
* Opera 12

## Requirements

* Rails 3
* jQuery (tested with v1.10)

## Usage

1. Add the gem to your Rails app.
2. Add the following to the controllers that generate flash messages (or better, to the `ApplicationController`):

        after_filter :prepare_unobtrusive_flash

    Important! **Flash messages are NOT HTML escaped**, so you can use any markup in them. Take additional care to protect yourself from injection attacks if necessary.

3. Include `require unobtrusive_flash` in your `application.js`.

4. Delete flash rendering code from your views, if there is any.

### Option 1: For Bootstrap projects

Also `require unobtrusive_flash_bootstrap` in your `application.js`. This file contains flash message UI based on the [Bootstrap alert component](http://getbootstrap.com/components/#alerts).

### Option 2: For non-Bootstrap projects

Also `require unobtrusive_flash_ui` in your `application.js` and `require unobtrusive_flash_ui` in your `application.css`. These files contain a no-frills flash message UI that works out of the box.

### Option 3: Roll your own

Unobtrusive Flash triggers jQuery events when flash is received. If you want to integrate it with your own UI, implement and bind a handler:

    flashHandler = function(e, params) {
      alert('Received flash message '+params.message+' with type '+params.type);
    };

    $(window).bind('rails:flash', flashHandler);

 
## Bonus: show 'flash messages' from the front-end

Both Bootstrap and non-Bootstrap versions contain a function to display flash messages:

    // Shown for 5 seconds (default)
    $.showFlashMessage('Hello World', {type: 'notice'})
    // Shown forever
    $.showFlashMessage('Error', {type: 'error', timeout: 0})

* * *

&copy; 2010-2013 Leonid Shevtsov, released under the MIT license
