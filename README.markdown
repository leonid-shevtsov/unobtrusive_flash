# Unobtrusive flash messages for Rails

**Version 1 users:** this gem got a major redesign in version 2, please read the documentation

Ever got tired of pages that can't be cached because they contain flash messages?

Ever got tired of writing custom code to handle flash messages passed in AJAX responses?

Here comes the solution.

`unobtrusive_flash` takes your flash messages for the backend and automagically passes them to the frontend via
HTTP cookies. This works with both **regular page loads**, **jQuery AJAX requests**, and **turbolinks** (from v3), does not tamper with the page body and requires
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

* Rails >=3
* jQuery (tested with v1.10)

## Usage

1. Add the `unobtrusive_flash` gem to your Gemfile.

        gem 'unobtrusive_flash', '>=3'

2. Add the following to the controllers that generate flash messages (or better, to the `ApplicationController`):

        after_filter :prepare_unobtrusive_flash

    Flash messages are HTML escaped in the same manner as regular Rails view code: if a message is not `html_safe`, it is escaped, otherwise not. This lets you use helpers such as `link_to` in your messages.

3. Include `require unobtrusive_flash` in your `application.js`.

4. Delete flash rendering code from your views, if there was any.

5. You have three options to render flash messages on the frontend:

### Option 1: For Bootstrap projects

Also `require unobtrusive_flash_bootstrap` in your `application.js`. This file contains flash message UI based on the [Bootstrap alert component](http://getbootstrap.com/components/#alerts).

Either declare a `.unobtrusive-flash-container` element somewhere on the page to contain the alerts, or Unobtrusive flash will choose the first `.container` or `.container-fluid` element on the page, or fall back to the `body`.

### Option 2: For non-Bootstrap projects

Also `require unobtrusive_flash_ui` in your `application.js` and `require unobtrusive_flash_ui` in your `application.css`. These files contain a no-frills flash message UI that works out of the box.

### Option 3: Roll your own

Unobtrusive Flash triggers jQuery events when flash is received. If you want to integrate it with your own UI, implement and bind a handler:

    flashHandler = function(e, params) {
      alert('Received flash message '+params.message+' with type '+params.type);
    };

    $(window).bind('rails:flash', flashHandler);


## Using UnobtrusiveFlash with a frontend framework that doesn't use jQuery for AJAX

Call `UnobtrusiveFlash.showFlashFromCookies()` in your Javascript after a completed request.
 
## Bonus: show 'flash messages' from the front-end

Both Bootstrap and non-Bootstrap versions contain a function to display flash messages:

    // Shown for 5 seconds (default)
    UnobtrusiveFlash.showFlashMessage('Hello World', {type: 'notice'})
    // Shown forever
    UnobtrusiveFlash.showFlashMessage('Error', {type: 'error', timeout: 0})

* * *

&copy; 2010-2014 Leonid Shevtsov, released under the MIT license
