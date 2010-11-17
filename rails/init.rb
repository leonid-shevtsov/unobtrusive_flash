require '../lib/unobtrusive_flash'

ActionController::Base.send(:include, UnobtrusiveFlash)
