require 'unobtrusive_flash'
require 'rails'

module UnobtrusiveFlash
  class Railtie < Rails::Railtie
    initializer 'unobtrusive_flash.initialize', :after => :after_initialize do
      ActionController::Base.send :include, UnobtrusiveFlash
    end
  end
end
