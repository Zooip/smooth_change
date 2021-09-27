# frozen_string_literal: true

require_relative "lib/smooth_change/version"

Gem::Specification.new do |spec|
  spec.name          = "smooth_change"
  spec.version       = SmoothChange::VERSION
  spec.authors       = ["Alexandre Narbonne"]
  spec.email         = ["alexandre.narbonne@yahoo.fr"]

  spec.summary       = "Change your API behaviour without breaking everything"
  # spec.description   = "TODO: Write a longer description or delete this line."
  spec.homepage      = "https://github.com/Zooip/smooth_change"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.5.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to 'https://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Zooip/smooth_change"
  spec.metadata["changelog_uri"] = "https://github.com/Zooip/smooth_change/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 5.2.3", "< 7"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rbs", "~> 1.6", ">= 1.6.2"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-rails", "~> 3.4", ">= 3.4.2"
  spec.add_development_dependency "rubocop", "~> 1.21"
  spec.add_development_dependency "rubocop-performance", "~> 1.11"
  spec.add_development_dependency "rubocop-rspec", "~> 2.5"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
