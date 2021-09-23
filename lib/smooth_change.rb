# frozen_string_literal: true

require_relative "smooth_change/version"
require_relative "smooth_change/configuration"
require_relative "smooth_change/client_feature_toggler"
require_relative "smooth_change/feature"

module SmoothChange # rubocop:disable Style/Documentation
  class Error < StandardError; end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end
  end
end
