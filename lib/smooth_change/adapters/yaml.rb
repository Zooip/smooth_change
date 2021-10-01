# frozen_string_literal: true

module SmoothChange
  module Adapters
    # Load features from a YAML file
    class Yaml
      def initialize(file:)
        @file_content = if file.respond_to?(:read)
                          # @type var file: IO
                          file.read
                        else
                          # @type var file: String
                          File.read(file.to_s)
                        end
        parse_file
      end

      def features
        @features ||= HashWithIndifferentAccess.new
      end

      # @return [Feature]
      # @param [string] feature_name
      def get(feature_name)
        features[feature_name.to_s] || Feature.new(feature_name, :opt_in)
      end

      private

      def parse_file
        file_content = ::YAML.safe_load(@file_content)
        file_content["features"].each do |name, opts|
          features[name] = Feature.new(name, opts["mode"])
        end
      end
    end
  end
end
