# frozen_string_literal: true

SimpleCov.start do
  load_profile "test_frameworks"
  enable_coverage :branch
  add_filter %r{^/sig/}

  add_group "Libraries", "lib/"
end
