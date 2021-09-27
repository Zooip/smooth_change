# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"

require_relative "./spec_helper"
require_relative File.expand_path("dummy/config/environment", __dir__)


require "rspec/rails"

