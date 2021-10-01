# frozen_string_literal: true

module SmoothChange
  module Adapters
    # Load features from a YAML file
    class Memory
      def initialize(features: {})
        @features = features.transform_keys(&:to_s)
      end

      attr_reader :features

      # @return [Feature]
      # @param [string] feature_name
      def get(feature_name)
        features[feature_name.to_s] || Feature.new(feature_name, :opt_in)
      end
    end
  end
end
