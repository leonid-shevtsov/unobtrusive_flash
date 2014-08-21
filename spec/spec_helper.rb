require 'bundler'
require 'rspec'
require 'capybara/rspec'

ENV['JQUERY_VERSION'] ||= '2.1.1'

require 'rails'
require 'unobtrusive_flash'
require 'support/rails_app'

Capybara.app = TestApp

if ENV['TRAVIS']
  # Selenium not available on TraviS CI without many pains.
  require 'capybara/poltergeist'
  Capybara.javascript_driver = :poltergeist
else
  # But Selenium supports turbolinks and PhantomJS does not
  Capybara.javascript_driver = :selenium
end
