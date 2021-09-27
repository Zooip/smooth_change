# frozen_string_literal: true

class ApiController < ApplicationController
  def test_opt_in
    if smooth_change.enabled?(:feature_opt_in)
      render json: { use_opt_in_feature: true }
    else
      render json: { use_opt_in_feature: false }
    end
  end

  def test_opt_out
    if smooth_change.enabled?(:feature_opt_out)
      render json: { use_opt_out_feature: true }
    else
      render json: { use_opt_out_feature: false }
    end
  end

  def test_model
    @my_model = TestModel.new
    use_feature = @my_model.did_use_feature?
    render json: { use_model_feature: use_feature }
  end
end
