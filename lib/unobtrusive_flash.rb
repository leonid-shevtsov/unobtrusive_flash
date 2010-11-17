module UnobtrusiveFlash

protected
  def prepare_unobtrusive_flash
    if (response.code.to_s=~/^(2|4)/) && flash.any?
      headers['X-Flash-Messages'] = flash.to_json
      flash.discard
    end
  end
end
