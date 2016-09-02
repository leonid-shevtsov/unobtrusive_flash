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

        cookie_flash += UnobtrusiveFlash::ControllerMixin.sanitize_flash(flash, unobtrusive_flash_keys)
        cookie_flash.uniq!
        cookies[:flash] = {:value => cookie_flash.to_json, :domain => unobtrusive_flash_domain}
        flash.discard
      end
    end

    # Setting cookies for :all domains is broken for Heroku apps, read this article for details
    # https://devcenter.heroku.com/articles/cookies-and-herokuapp-com
    # You can also override this method in your controller if you need to customize the cookie domain
    def unobtrusive_flash_domain
      if request.host =~ /\.herokuapp\.com$/
        request.host
      else
        :all
      end
    end

    # List of all flash keys that will be displayed on the frontend. Override
    # this method if you use more flash types.
    def unobtrusive_flash_keys
      [:notice, :alert, :error]
    end

    class << self
      # Prepares a safe and clean version of the flash hash for the frontend
      # flash - value of `flash` controller attribute
      # displayable_flash_keys - list of flash keys that will be displayed
      def sanitize_flash(flash, displayable_flash_keys)
        displayable_flash = flash.select { |key, value| displayable_flash_keys.include?(key.to_sym) }
        displayable_flash.map do |key, value|
          html_safe_value = value.html_safe? ? value : ERB::Util.html_escape(value)
          [key, html_safe_value]
        end
      end
    end
  end
end
