# frozen_string_literal: true

require "active_support"

module SmoothChange
  # Thread safe Rails request store
  class Current < ActiveSupport::CurrentAttributes
    attribute :smooth_change

    # override with default value
    def smooth_change
      self.smooth_change = SmoothChange::ClientFeatureToggler.new unless attributes[:smooth_change]
      attributes[:smooth_change]
    end

    delegate :enabled?, to: :smooth_change
  end
end
