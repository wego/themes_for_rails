module ThemesForRails
  module Digests

    def digest_for_image_file(asset, theme_context)
      if digest_enabled?
        File.basename(Rails.application.config.assets.digests["#{theme_context}/images/#{asset}"])
      else
        asset
      end
    end

    def digest_for_javascript_file(asset, theme_context)
      if digest_enabled?
        File.basename(Rails.application.config.assets.digests["#{theme_context}/javascripts/#{asset}"])
      else
        asset
      end
    end

    def digest_for_stylesheet_file(asset, theme_context)
      if digest_enabled?
        File.basename(Rails.application.config.assets.digests["#{theme_context}/stylesheets/#{asset}"])
      else
        asset
      end
    end

    def digest_enabled?
      Rails.application.config.respond_to?('assets') && Rails.application.config.assets.digest_themes_for_rails && Rails.application.config.assets.digests
    end

  end
end