require 'bundler'
require 'rspec'
require 'capybara/rspec'

ENV['JQUERY_VERSION'] ||= '2.1.1'

require 'rails'
require 'unobtrusive_flash'
require 'support/rails_app'
require 'support/capybara_driver'

Capybara.app = TestApp
