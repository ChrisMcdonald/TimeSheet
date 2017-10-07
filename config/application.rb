require_relative 'boot'
require 'csv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Devise3
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

	  config.assets.paths << Rails.root.join('images')


	  class UnauthorizedActionException < StandardError
		  attr :message

		  def initialize(message)
			  @message = message
		  end
	  end

  end
end
