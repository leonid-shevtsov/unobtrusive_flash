require 'active_support/core_ext/string/output_safety'

module UnobtrusiveFlash
  module ControllerMixin
    protected

    def prepare_unobtrusive_flash
      if flash.any?
        cookie_flash = []
        if cookies['flash']
          cookie_flash = JSON.parse(cookies['flash']) rescue nil
          cookie_flash = [] unless cookie_flash.is_a? Array
        end

        messages = UnobtrusiveFlash::ControllerMixin.prepare_flash_messages(flash)
        cookie_flash += UnobtrusiveFlash::ControllerMixin.sanitize_messages(messages)

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

    class << self
      def prepare_flash_messages(flash)
        flash.to_a.select do |key, value|
          unless [true, false].include?(value)
            [key, value]
          end
        end
      end

      def sanitize_messages(messages)
        messages.map do |key, value|
          html_safe_value = value.html_safe? ? value : ERB::Util.html_escape(value)
          [key, html_safe_value]
        end
      end
    end
  end
end
