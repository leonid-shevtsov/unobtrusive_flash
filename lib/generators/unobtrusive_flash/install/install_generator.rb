# encoding: utf-8
module UnobtrusiveFlash
  class InstallGenerator < Rails::Generators::Base
    desc "Copies unobtrusive_flash.css and .js to their corresponding locations"

    source_root File.expand_path('../../../templates', __FILE__)

    def copy_files
      empty_directory 'public/stylesheets'
      template 'unobtrusive_flash.css', 'public/stylesheets/unobtrusive_flash.css'
      empty_directory 'public/javascripts'
      template 'unobtrusive_flash.js', 'public/javascripts/unobtrusive_flash.js'
    end
  end
end
