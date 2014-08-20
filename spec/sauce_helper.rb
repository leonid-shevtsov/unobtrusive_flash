require "sauce"
require "sauce/capybara"

SAUCE_CONNECT_PORT = 2001

Sauce.config do |config|
  config[:os], config[:browser], config[:browser_version] = ENV['SAUCE_BROWSER'].split(':')
  config[:application_port] = SAUCE_CONNECT_PORT
end

Capybara.javascript_driver = :sauce

RSpec.configure do |config|
  config.before(:suite) do
    thread = Thread.new do
      Capybara.run_default_server(Capybara.app, SAUCE_CONNECT_PORT)
    end
    RSpec.instance_variable_set '@server_thread', thread
  end

  config.after(:suite) do
    thread = RSpec.instance_variable_get('@server_thread')
    Thread.kill(thread) if thread
  end
end
