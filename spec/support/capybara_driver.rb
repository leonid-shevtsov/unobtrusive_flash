if ENV['TRAVIS']
  require "sauce"
  require "sauce/capybara"
  Sauce.config do |c|
    c[:browsers] = [
      ["Windows 8", "Internet Explorer", "10"],
      ["Windows 7", "Firefox", "20"],
      ["OS X 10.8", "Safari", "6"],
      ["Linux", "Chrome", nil]
    ]
  end
  Capybara.javascript_driver = :sauce
else
  Capybara.javascript_driver = :selenium
end
