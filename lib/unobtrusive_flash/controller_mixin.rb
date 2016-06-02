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
        cookies[:flash] = {:value => cookie_flash.to_json, :domain => unobtrusive_flash_domain}
        flash.discard
      end
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
