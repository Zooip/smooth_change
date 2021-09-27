# frozen_string_literal: true

class TestModel
  def did_use_feature?
    SmoothChange::Current.enabled?(:feature_model)
  end
end
