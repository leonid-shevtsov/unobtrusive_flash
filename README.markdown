# Unobtrusive flash messages for Rails [![Build Status](https://travis-ci.org/leonid-shevtsov/unobtrusive_flash.svg?branch=master)](https://travis-ci.org/leonid-shevtsov/unobtrusive_flash)

Ever got tired of pages that can't be cached because they contain flash messages?

Ever got tired of writing custom code to handle flash messages passed in AJAX responses?

Here comes the solution.

`unobtrusive_flash` takes your flash messages for the backend and automagically passes them to the frontend via
HTTP cookies. This works with both **regular page loads**, **jQuery AJAX requests**, and **turbolinks** (from v3), does not tamper with the page body and requires
about 3 extra lines of code in your app - how's that for unobtrusive?

You can pass up to 4K of text into flash this way, and you don't need to worry about cookie size since they are
cleared immediately upon rendering.

Tested in all major browsers, including Internet Explorer 8 and later.

## Requirements

* Rails >=3 (Latest versions of 3.2, 4.0, 4.1, 4.2, and 5.0 are automatically tested)
* jQuery (Latest versions of jQuery 1, 2 and 3 are automatically tested)

## Usage

1. Add the `unobtrusive_flash` gem to your Gemfile.

    ```ruby
    gem 'unobtrusive_flash', '>=3'
    ```

2. Add the following to the controllers that generate flash messages (or better, to the `ApplicationController`):

    ```ruby
    after_filter :prepare_unobtrusive_flash
    ```

    Flash messages are HTML escaped in the same manner as regular Rails view code: if a message is not `html_safe`, it is escaped, otherwise not. This lets you use helpers such as `link_to` in your messages.

3. Include `require unobtrusive_flash` in your `application.js`.

4. Delete flash rendering code from your views, if there was any.

5. You have three options to render flash messages on the frontend:

### Option 1: For Bootstrap projects

Also `require unobtrusive_flash_bootstrap` in your `application.js`. This file contains flash message UI based on the [Bootstrap alert component](http://getbootstrap.com/components/#alerts).

Either declare a `.unobtrusive-flash-container` element somewhere on the page to contain the alerts, or Unobtrusive flash will choose the first `.container` or `.container-fluid` element on the page, or fall back to the `body`.

If you want the flash messages to disappear automatically, set this in your Javascript:

```javascript
UnobtrusiveFlash.flashOptions['timeout'] = 2000; // milliseconds
```

You can config the resulting mapping classes like this:
```javascript
UnobtrusiveFlash.flashOptions.mapping.notice = 'success'
```

### Option 2: For non-Bootstrap projects

Also `require unobtrusive_flash_ui` in your `application.js` and `require unobtrusive_flash_ui` in your `application.css`. These files contain a no-frills flash message UI that works out of the box.

If you want the flash messages to disappear automatically, set this in your Javascript:

```javascript
UnobtrusiveFlash.flashOptions['timeout'] = 2000; // milliseconds
```

### Option 3: Roll your own

Unobtrusive Flash triggers jQuery events when flash is received. If you want to integrate it with your own UI, implement and bind a handler:

```javascript
flashHandler = function(e, params) {
  alert('Received flash message '+params.message+' with type '+params.type);
};

$(window).bind('rails:flash', flashHandler);
```

## Using UnobtrusiveFlash with a frontend framework that doesn't use jQuery for AJAX

Call `UnobtrusiveFlash.showFlashFromCookies()` in your Javascript after a completed request.

## Bonus: show 'flash messages' from the front-end

Both Bootstrap and non-Bootstrap versions contain a function to display flash messages:

```javascript
// Shown for 5 seconds (default)
UnobtrusiveFlash.showFlashMessage('Hello World', {type: 'notice'})
// Shown forever
UnobtrusiveFlash.showFlashMessage('Error', {type: 'error', timeout: 0})
```

## Using custom flash keys

By default, Unobtrusive Flash only displays a limited set of flash types [(see UnobtrusiveFlash::ControllerMixin#unobtrusive_flash_keys)](https://github.com/leonid-shevtsov/unobtrusive_flash/blob/master/lib/unobtrusive_flash/controller_mixin.rb#L36). This is because some libraries use `flash` to keep data that is not directed at the user; for example, [Devise](https://github.com/plataformatec/devise) uses a boolean `flash[:timedout]`. If you use other keys to store messages, override `unobtrusive_flash_keys` in your controller:

```ruby
class ApplicationController
  def unobtrusive_flash_keys
    super << :success
  end
end
```

## Issue with certain "hosted domains"

There are [certain domains](https://publicsuffix.org/list/) that are considered "public" or "hosting" and specifically don't share cookies across subdomains. An example is `herokuapp.com` - a cookie set for `yourapp.herokuapp.com` will not be applied for `myapp.herokuapp.com`. This breaks the logic of `unobtrusive_flash` which is tuned for regular domains that could have internal subdomains.

In this case, you should explicitly specify your domain:

```ruby
class ApplicationController
  def unobtrusive_flash_domain
    request.host # last resort is hardcoding the domain here
  end
end
```

## Running tests

This plugin's test suite includes a full set of integration tests for various versions of Rails. To run them:

```shell
bundle install
appraisal install
appraisal rake spec
```

The same tests are ran on Travis CI against multiple versions of Ruby and jQuery.

* * *

&copy; 2010-2016 [Leonid Shevtsov](http://leonid.shevtsov.me) and [contributors](https://github.com/leonid-shevtsov/unobtrusive_flash/graphs/contributors), released under the MIT license
