require 'active_support/core_ext/string/output_safety'

module UnobtrusiveFlash
  module ControllerMixin
    protected

    def prepare_unobtrusive_flash
      return unless flash.any?
      # TODO: replace configuration based on overriding methods with a conventional config block
      cookies[:flash] = {
        value: UnobtrusiveFlash::ControllerMixin.append_flash_to_cookie(cookies[:flash], flash, unobtrusive_flash_keys),
        domain: unobtrusive_flash_domain
      }
      flash.discard
    end

    # Setting cookies for :all domains is broken for Heroku apps, read this article for details
    # https://devcenter.heroku.com/articles/cookies-and-herokuapp-com
    #
    # Setting cookies for :all domains also appears to be broken for apps hosted on EC2 behind
    # AWS ELB. No written documentation on that yet, only quantitive analysis based on
    # obvservation of a few instances of load balancers and EC2 instances accessed directly
    # via their IP addresses.
    #
    # You can also override this method in your controller if you need to customize the cookie domain
    def unobtrusive_flash_domain
      if request.host =~ /\.herokuapp\.com$/ || request.host =~ /\.amazonaws\.com$/
        request.host
      else
        :all
      end
    end

    # List of all flash keys that will be displayed on the frontend. Override
    # this method if you use more flash types.
    def unobtrusive_flash_keys
      [:notice, :alert, :error, :success, :warning]
    end

    class << self
      # Prepares a safe and clean version of the flash hash for the frontend
      # flash - value of `flash` controller attribute
      # displayable_flash_keys - list of flash keys that will be displayed
      def sanitize_flash(flash, displayable_flash_keys)
        displayable_flash = flash.select { |key, value| displayable_flash_keys.include?(key.to_sym) }
        displayable_flash.map do |key, value|
          html_safe_value = value.html_safe? ? value : ERB::Util.html_escape(value)
          [key.to_s, html_safe_value]
        end
      end

      def append_flash_to_cookie(existing_cookie, flash, unobtrusive_flash_keys)
        if existing_cookie
          cookie_flash = JSON.parse(existing_cookie) rescue []
        else
          cookie_flash = []
        end

        cookie_flash += sanitize_flash(flash, unobtrusive_flash_keys)

        cookie_flash.uniq.to_json
      end
    end
  end
end
