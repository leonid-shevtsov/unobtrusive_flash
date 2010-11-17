require 'rake'

spec = Gem::Specification.new do |s|
  s.author = 'Leonid Shevtsov'
  s.email = 'leonid@shevtsov.me'
  
  s.name = 'rails-unobtrusive-flash'
  s.version = '0.0.1'
  s.summary = 'Unobtrusive flash messages for rails'

  s.description = File.read('README.markdown')

  s.homepage = 'http://github.com/leonid-shevtsov/rails-unobtrusive-flash'

  s.files = FileList['lib//*', 'generators/*.rb', 'rails/init.rb', '[A-Z]*'].to_a

  s.has_rdoc = false
end
