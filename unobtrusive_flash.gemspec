# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'unobtrusive_flash/version'

Gem::Specification.new do |spec|
  spec.name          = "unobtrusive_flash"
  spec.version       = UnobtrusiveFlash::VERSION
  spec.authors       = ["Leonid Shevtsov"]
  spec.email         = ["leonid@shevtsov.me"]
  spec.summary = "Unobtrusive flash messages for Rails"
  spec.description   = <<EOT
unobtrusive_flash takes your flash messages for the backend and automagically passes them to the frontend via HTTP cookies.
This works with both regular page loads and AJAX requests, does not tamper with the page body and requires about 3 extra
lines of code in your app - how's that for unobtrusive?
EOT
  spec.homepage      = "https://github.com/leonid-shevtsov/unobtrusive_flash"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "railties"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", '~>3'
  spec.add_development_dependency "rspec-mocks", '~>3'
  spec.add_development_dependency "appraisal"
  spec.add_development_dependency "capybara", '>=2.5'
  spec.add_development_dependency 'poltergeist', '>=1.10.0'
end
