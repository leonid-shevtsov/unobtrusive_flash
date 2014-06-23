## 2014-06-23 3.1.0

* Extracted default flash options to `UnobtrusiveFlash.flashOptions` so you can set the message timeout.
* Use `hostname` when nuking cookies by @zeppelin [#14]
* Check $flashContainer dynamically by @nfedyashev [#15].
* Fixed issues with applications on the .herokuapp.com domain [#16].

## 2014-03-07 3.0.0

* Moved Javascript methods to an `UnobtrusiveFlash` module. This breaks calling `$.showFlashMessage`, hence another major release [#11]
* Make sure that the flash events are invoked after a handler had a chance to bind [#10]
* Changed default alerts to never autohide [#6]
* Bootstrap handler: All conventional Rails notices are correctly styled by @conzett [#12]
* Turbolinks are supported thanks to @yoyos [#13]
* Fixes to cookie nuking by @asaletnik [#7]

## 2013-12-21 2.1.0

* Changed message escaping logic to use the Rails html_safe conventions (Possibly breaking change)

## 2013-10-09 2.0.0

* Grand refactoring
* Compatibility with Rails 3 Asset Pipeline
* Dropped compatibility with Rails 2
* Decoupled logic from presentation
* Compatibility with Bootstrap
* Event-driven architecture