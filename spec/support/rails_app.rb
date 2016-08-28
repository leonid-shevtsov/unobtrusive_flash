# From https://gist.github.com/josevalim/1942658

require 'rails'
require 'action_controller/railtie'
require 'sprockets/railtie'
require 'jquery-rails'
if Rails::VERSION::MAJOR == 4
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
  config.assets.precompile += %w(ui.js bootstrap.js api.js)

  config.middleware.delete Rack::Lock

  if Rails::VERSION::MAJOR < 4
    config.middleware.delete ActionDispatch::BestStandardsSupport
  end

  config.secret_token = "49837489qkuweoiuoqwehisuakshdjksadhaisdy78o34y138974xyqp9rmye8yrpiokeuioqwzyoiuxftoyqiuxrhm3iou1hrzmjk"
  config.secret_key_base = "1234567890"
end

class TestController < ActionController::Base
  layout false

  if Rails::VERSION::MAJOR >= 4
    before_action :set_inline_flash, except: %w(ajax_flash turbolinks_target)
    after_action :prepare_unobtrusive_flash
  else
    before_filter :set_inline_flash, except: %w(ajax_flash turbolinks_target)
    after_filter :prepare_unobtrusive_flash
  end

  def ui
    flash[:timedout] = 'timedout flash'
  end

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
