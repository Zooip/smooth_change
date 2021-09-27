# frozen_string_literal: true

SmoothChange.configure do |config|
  config.adapter = SmoothChange::Adapters::Yaml.new(file: Rails.root.join("config/smooth_change.yml"))
end
