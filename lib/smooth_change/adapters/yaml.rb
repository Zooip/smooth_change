module SmoothChange
  module Adapters
    class Yaml

      def initialize(file:)
        set_file_content(file)
        parse_file
      end

      def features
        @features ||= {}.with_indifferent_access
      end

      # @return [Feature]
      # @param [string] feature_name
      def get(feature_name)
        @features[feature_name]
      end

      private

      def set_file_content(file_ot_path)
        @file_content = if file_ot_path.respond_to?(:read)
                          file_ot_path.read
                        else
                          File.read(file_ot_path)
                        end
      end

      def parse_file
        file_content = ::YAML.safe_load(@file_content)
        file_content["features"].each do |name, opts|
          features[name] = Feature.new(name, opts["mode"])
        end
      end

    end
  end
end