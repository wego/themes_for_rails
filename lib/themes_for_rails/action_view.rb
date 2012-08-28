# encoding: utf-8
module ThemesForRails
  
  module ActionView

    extend ActiveSupport::Concern

    included do
      include ThemesForRails::CommonMethods
      include ThemesForRails::Digests
    end

    def current_theme_stylesheet_path(asset)
      theme_stylesheet_path(asset)
    end
    
    def current_theme_javascript_path(asset)
      theme_javascript_path(asset)
    end

    def current_theme_image_path(asset)
      theme_image_path(asset)
    end

    def theme_stylesheet_path(asset, new_theme_name = self.theme_name)
      asset_with_digest = digest_for_stylesheet_file("#{asset}.css", new_theme_name)
      base_theme_stylesheet_path(:theme => new_theme_name, :asset => asset_with_digest)
    end

    def theme_javascript_path(asset, new_theme_name = self.theme_name)
      asset_with_digest = digest_for_javascript_file("#{asset}.js", new_theme_name)
      base_theme_javascript_path(:theme => new_theme_name, :asset => asset_with_digest)
    end

    def theme_image_path(asset, new_theme_name = self.theme_name)
      asset_with_digest = digest_for_image_file(asset, new_theme_name)
      base_theme_image_path(:theme => new_theme_name, :asset => asset_with_digest)
    end
    
    def theme_image_tag(source, options = {})
      image_tag(theme_image_path(source), options)
    end

    def theme_image_submit_tag(source, options = {})
      image_submit_tag(theme_image_path(source), options)
    end

    def theme_javascript_include_tag(*files)
      options = files.extract_options!
      options.merge!({ :type => "text/javascript" })
      files_with_options = files.collect {|file| theme_javascript_path(file) }
      files_with_options += [options]

      javascript_include_tag(*files_with_options)
    end

    def theme_stylesheet_link_tag(*files)
      options = files.extract_options!
      options.merge!({ :type => "text/css" })
      files_with_options = files.collect {|file| theme_stylesheet_path(file) }
      files_with_options += [options]

      stylesheet_link_tag(*files_with_options)
    end
  end
end
