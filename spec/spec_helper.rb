require 'bundler'
require 'rspec'
require 'capybara/rspec'

ENV['JQUERY_VERSION'] ||= '2.1.1'

require 'rails'
require 'unobtrusive_flash'
require 'support/rails_app'

Capybara.app = TestApp

if ENV['TRAVIS']
  require 'sauce_helper'
else
  Capybara.javascript_driver = :selenium
end
