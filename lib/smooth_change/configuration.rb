# frozen_string_literal: true

module SmoothChange
  # Store SmoothChange gem's global configuration
  class Configuration
    def initialize
      set_defaults!
    end

    attr_accessor :http_header_name,
                  :adapter

    private

    def set_defaults!
      self.http_header_name = "X-ApiFeatureFlags"
      self.adapter = Adapters::Memory.new
    end
  end
end
