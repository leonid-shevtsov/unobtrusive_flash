# Unobtrusive flash messages for Rails

Ever got tired of pages that can't be cached because they contain flash messages?

Ever got tired of writing custom code to handle flash messages passed in AJAX responses?

Here comes the solution.

`rails-unobtrusive-flash` takes your flash messages for the backend and automagically passes them to the frontend via
HTTP headers. It is an improvement over my [cacheable-flash-query](http://github.com/leonid-shevtsov/cacheable-flash-jquery)
plugin and a by-product of my work at [RailsWare](http://github.com/railsware).

## Requirements

* Rails 2.3 or 3
* jQuery (maybe i'll make it agnostic in the future)

## Usage

1. Add the gem to your Rails app.
2. Run `script/generate unobtrusive_flash` or `rails g unobtrusive_flash`
3. Add the following to the controllers that generate flash messages (or better, to the `ApplicationController`):

        after_filter :prepare_unobtrusive_flash
 
4. Add `unobtrusive_flash.css` and `unobtrusive_flash.js` to your layouts. No custom markup is needed.
5. That's all! You can also edit the generated CSS/JS to your liking.

---

&copy; 2010 Leonid Shevtsov, released under the MIT license
