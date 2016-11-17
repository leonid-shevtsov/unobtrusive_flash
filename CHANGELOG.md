## 2016-11-17 3.3.1

* Added `:success` and `:warning` to list of Flash keys visible by default

## 2016-11-08 3.3.0

* Now compatible with jQuery 1, 2 and 3.
* Now compatible with Rails 5.
* Now compatible with turbolinks 5.
* Make bootstrap flash mapping configurable [#31]
* Do not repeat flash messages [#32]
* Support AWS ELB out of the box [#33]
* Only show user-facing flash messages [#21]
* Tested with JRuby

## 2015-11-06 3.2.0

* Support passing flash with non-successful (non-200) AJAX requests thanks to @Markwallow [#28]
* Tested with Rails 4.2

## 2015-10-23 3.1.1

* Fix typo that didn't clear domainless cookies thanks to @pavelgnom [#23]

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
