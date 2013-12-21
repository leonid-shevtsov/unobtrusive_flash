require 'active_support/core_ext/string/output_safety'

module UnobtrusiveFlash
  module ControllerMixin
    protected

    def prepare_unobtrusive_flash
      if flash.any?
        cookie_flash = []
        if cookies['flash']
          cookie_flash = JSON.parse(cookies['flash']) rescue nil
          cookie_flash=[] unless cookie_flash.is_a? Array
        end

        cookie_flash += UnobtrusiveFlash::ControllerMixin.sanitize_flash(flash)
        cookies[:flash] = {:value => cookie_flash.to_json, :domain => :all}
        flash.discard
      end
    end

    class << self
      def sanitize_flash(flash)
        flash.to_a.map do |key, value|
          html_safe_value = value.html_safe? ? value : ERB::Util.html_escape(value)
          [key, html_safe_value]
        end
      end
    end
  end
end
