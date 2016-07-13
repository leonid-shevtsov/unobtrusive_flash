# From https://gist.github.com/josevalim/1942658

require 'rails'
require 'action_controller/railtie'
require 'sprockets/railtie'
require 'jquery-rails'
if Rails.version =~ /^4\./
  require 'turbolinks'
  require 'jquery-turbolinks'
end


class TestApp < Rails::Application
  routes.append do
    %w(api ui bootstrap ajax_flash turbolinks jquery_turbolinks turbolinks_target).each do |action|
      get "/test/#{action}" => "test##{action}"
    end
  end

  # Enable cache classes. Production style.
  config.cache_classes = true
  config.eager_load = false

  config.logger = Logger.new(STDOUT)
  config.action_controller.view_paths = [ File.expand_path(__FILE__ + '/../views') ]
  config.assets.paths = [ File.expand_path(__FILE__ + '/../assets/javascripts') ]
  config.assets.enabled = true
  config.assets.compile = true

  config.assets.precompile += %w(api.js bootstrap.js ui.js)

  config.middleware.delete "Rack::Lock"
  unless Rails::VERSION::MAJOR >= 5
    config.middleware.delete "ActionDispatch::BestStandardsSupport"
  end

  # We need a secret token for session, cookies, etc.
  config.secret_token = "49837489qkuweoiuoqwehisuakshdjksadhaisdy78o34y138974xyqp9rmye8yrpiokeuioqwzyoiuxftoyqiuxrhm3iou1hrzmjk"
end

class TestController < ActionController::Base
  layout false

  before_filter :set_inline_flash, except: %w(ajax_flash turbolinks_target)
  after_filter :prepare_unobtrusive_flash

  def turbolinks_target
    flash[:notice] = 'Turbolink Notice'
  end

  def ajax_flash
    flash[:error] = 'Ajax Error'
    head :ok
  end

  def set_inline_flash
    flash[:notice] = 'Inline Notice'
  end
end

# Initialize the app (originally in config/environment.rb)
TestApp.initialize!
