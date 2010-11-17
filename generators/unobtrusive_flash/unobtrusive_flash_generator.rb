# encoding: utf-8

class UnobtrusiveFlashGenerator < Rails::Generator::Base

  def manifest
    record do |m|
      m.directory File.join('public', 'stylesheets')
      m.template 'unobtrusive_flash.css', File.join('public', 'stylesheets', 'unobtrusive_flash.css')

      m.directory File.join('public', 'javascripts')
      m.template 'unobtrusive_flash.js', File.join('public', 'javascripts', 'unobtrusive_flash.js')
    end
  end

  protected

  def banner
    %{Usage: #{$0} #{spec.name}\nCopies unobtrusive_flash.css and .js to their corresponding locations}
  end
 
  def source_root
    File.expand_path('../../../lib/generators/templates', __FILE__)
  end

end


