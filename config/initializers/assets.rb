# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( rouge.css )

# patch to fix compiling css.erb
# https://github.com/quinn/sass_rails_patch/blob/master/lib/sass_rails_patch.rb
require 'sass/rails'

class Sass::Rails::Importer
  def sass_file? filename
    filename = filename.to_s
    SASS_EXTENSIONS.keys.any?{|ext| filename.match /#{ext}$/}
  end
end
