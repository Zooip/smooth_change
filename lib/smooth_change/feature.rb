# frozen_string_literal: true

module SmoothChange
  # A feature to be mentioned by a feature flag
  class Feature
    attr_accessor :name
    attr_reader :mode

    def initialize(name, mode)
      self.name = name
      self.mode = mode
    end

    # @param [String,Symbol] value
    # @return [String,Symbol] value
    # @raise ArgumentError on unexpected value
    def mode=(value)
      @mode = case value.to_s
              when "opt_in" then :opt_in
              when "opt_out" then :opt_out
              else raise ArgumentError, "mode must be one of : opt_in, opt_out "
              end
    end

    # @return [Boolean]
    def enabled_with?(feature_toggler)
      value = feature_toggler.value_for(name)
      return default_enabled_value if value.nil?

      !!value
    end

    # @return [Boolean]
    def default_enabled_value
      mode == :opt_out
    end
  end
end
