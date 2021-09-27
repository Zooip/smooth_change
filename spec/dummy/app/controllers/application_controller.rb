# frozen_string_literal: true

class ApplicationController < ActionController::API
  include SmoothChange::ActionController::Helper

  before_action :store_smooth_change
end
