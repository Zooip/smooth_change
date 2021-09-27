# frozen_string_literal: true

require "active_support/concern"

module SmoothChange
  module ActionController
    # Add helper methods to use SmoothChange in your Rails's ActionControllers
    module Helper
      extend ActiveSupport::Concern

      def store_smooth_change
        SmoothChange::Current.smooth_change = smooth_change
      end

      def smooth_change
        @smooth_change ||= SmoothChange::ClientFeatureToggler.from_http_header(http_header_value)
      end

      private

      def http_header_value
        request.headers.fetch(SmoothChange.configuration.http_header_name, "")
      end
    end
  end
end
