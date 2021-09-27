# frozen_string_literal: true

require "active_support"

module SmoothChange
  class Current < ActiveSupport::CurrentAttributes
    attribute :smooth_change

    # override with default value
    def smooth_change
      unless attributes[:smooth_change]
        self.smooth_change = SmoothChange::ClientFeatureToggler.new
      end
      attributes[:smooth_change]
    end

    delegate :enabled?, to: :smooth_change
  end
end

