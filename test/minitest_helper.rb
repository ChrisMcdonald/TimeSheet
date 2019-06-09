# frozen_string_literal: true

ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
# require 'minitest/autorun'
require 'capybara/rails'
require 'active_support/testing/setup_and_teardown'

class IntegrationTest < MiniTest::Spec
  include Rails.application.routes.url_helpers
  include Capybara::DSL
  register_spec_type(/integration$/, self)

end

class HelperTest < MiniTest::Spec
  include ActiveSupport::Testing::SetupAndTeardown
  include ActionView::TestCase::Behavior
  register_spec_type(/Helper$/, self)
  include type: :feature
  # include WaitForAjax

end
# spec/support/wait_for_ajax.rb
module WaitForAjax
  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end
end

# RSpec.configure do |config|
# end
