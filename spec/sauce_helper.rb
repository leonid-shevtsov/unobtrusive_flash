require "sauce"
require "sauce/capybara"

SAUCE_CONNECT_PORT = 2001

Sauce.config do |c|
  c[:browsers] = [
    ["Windows 8", "Internet Explorer", "10"],
    ["Windows 7", "Firefox", "20"],
    ["OS X 10.8", "Safari", "6"],
    ["Linux", "Chrome", nil]
  ]
  c[:application_port] = SAUCE_CONNECT_PORT
end

# No one will start the app for us with the Sauce driver
Thread.new do
  Capybara.run_default_server(Capybara.app, SAUCE_CONNECT_PORT)
end

Capybara.javascript_driver = :sauce
