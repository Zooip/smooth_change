# frozen_string_literal: true

module SmoothChange
  module ActionController
    # Add helper methods to use SmoothChange in your Rails's ActionControllers
    module ControllerHelper
      private

      def http_header_value
        request.headers.fetch(SmoothChange.configuration.http_header_name)
      end
    end
  end
end
