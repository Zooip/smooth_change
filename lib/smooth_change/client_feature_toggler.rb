# frozen_string_literal: true

module SmoothChange
  # Store client features requirements
  class ClientFeatureToggler
    def initialize(values = {})
      @values = values.transform_keys(&:to_sym)
    end

    def values
      @values ||= {}
    end

    # if true : feature is wanted
    # if false : feature is explicitly not wanted
    # if nil : not specified
    def value_for(feature)
      values[feature.to_sym]
    end

    def enabled?(feature_name)
      feature = find_feature(feature_name)
      feature.enabled_with?(self)
    end

    # Http header is expected to be a comma separated list like :
    #   "feature1, !feature2, feature3"
    # Spaces between elements are ignored
    # A leading "!" means the feature request is opt-out
    def self.from_http_header(http_header_value)
      values = http_header_value
               .split(",")
               .each_with_object({}) do |item, memo|
        feature_name = item.strip

        # NOTE: delete_prefix! returns nil if prefix is not found
        enabled = !feature_name.delete_prefix!("!")
        memo[feature_name] = enabled
      end
      new(values)
    end

    private

    def adapter
      SmoothChange.configuration.adapter
    end

    # @return [SmoothChange::Feature]
    # @param [String] feature_name
    def find_feature(feature_name)
      adapter.get(feature_name)
    end
  end
end
