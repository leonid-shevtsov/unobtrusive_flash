require 'rake'

spec = Gem::Specification.new do |s|
  s.author = 'Leonid Shevtsov'
  s.email = 'leonid@shevtsov.me'

  s.name = 'unobtrusive_flash'
  s.version = '0.0.2'
  s.summary = 'Unobtrusive flash messages for Rails'

  s.description = <<EOT
unobtrusive_flash takes your flash messages for the backend and automagically passes them to the frontend via HTTP cookies.
This works with both regular page loads and AJAX requests, does not tamper with the page body and requires about 3 extra
lines of code in your app - how's that for unobtrusive?
EOT

  s.homepage = 'http://github.com/leonid-shevtsov/unobtrusive_flash'

  s.files = FileList['lib/**/*', 'generators/**/*.rb', 'rails/init.rb', 'init.rb', '[A-Z]*'].to_a

  s.has_rdoc = false
end
