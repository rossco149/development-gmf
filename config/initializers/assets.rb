# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w( jquery-1.4.3.min.js )
Rails.application.config.assets.precompile += %w( jquery.lightbox-0.5.min.js )
Rails.application.config.assets.precompile += %w( bannerRotator.js )
Rails.application.config.assets.precompile += %w( mcalpine.js )
Rails.application.config.assets.precompile += %w( styles.css jquery.lightbox-0.5.css rotator_style.css)
