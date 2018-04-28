# frozen_string_literal: true

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
    config.time_zone = 'Australia/Brisbane'

    config.before_configuration do

      ENV['git_client_id'] = 'fd5cd10d8bdff392350b'
      ENV['git_client_secret'] = '0ff201111e7c9a47ec675aec8d9c3595344ff632'

    end

  end
end
