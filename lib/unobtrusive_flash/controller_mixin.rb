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

        cookie_flash += flash.to_a
        cookies[:flash] = {:value => cookie_flash.to_json, :domain => :all}
        flash.discard
      end
    end
  end
end
