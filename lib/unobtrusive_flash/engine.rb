require 'unobtrusive_flash'
require "unobtrusive_flash/controller_mixin"
require 'rails'

module UnobtrusiveFlash
  class Engine < ::Rails::Engine
    initializer 'unobtrusive_flash.initialize', :after => :after_initialize do
      ActionController::Base.send :include, UnobtrusiveFlash::ControllerMixin
    end
  end
end
