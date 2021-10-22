# SmoothChange

[![Gem Version](https://badge.fury.io/rb/smooth_change.svg)](https://badge.fury.io/rb/smooth_change)
[![Maintainability](https://api.codeclimate.com/v1/badges/48a49429c6d98780a96e/maintainability)](https://codeclimate.com/github/Zooip/smooth_change/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/48a49429c6d98780a96e/test_coverage)](https://codeclimate.com/github/Zooip/smooth_change/test_coverage)

Deploy breaking changes on your API smoothly.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'smooth_change'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install smooth_change

## Configuration

```ruby
# config/initializers/smooth_change.rb
SmoothChange.configure do |config|
  config.adapter = SmoothChange::Adapters::Yaml.new(
    file: Rails.root.join("config/smooth_change.yml")
  )
end
```

```yaml
# config/smooth_change.yml
features:
  kittens_pagination:
    mode: opt_in
  new_kitten_filter:
    mode: opt_out
```

## Usage

Clients can express there feature capabilities using request header `X-FeatureCapabilities`.
It expects a comma separated values of each feature preferences :  
 - name of the feature you are ready to receive
 - name precessed with a `!` of feature you are not ready to receive

Exemple :
`X-FeatureCapabilities: !kittens_pagination,new_kitten_filter`

Will result in :
* `kittens_pagination`: not ready
* `new_kitten_filter`: ready

### In your controller
Simply include `SmoothChange::ActionController::Helper` in your controllers
(or `ApplicationController`). This module provides a `#smooth_change` helper
responding to `#enabled?(feature_name)` 

Exemple :
```ruby
require "smooth_change"

class ApplicationController < ActionController::API
  include SmoothChange::ActionController::Helper
end

class MyApiController < ActionController::API
  def index
    kittens = Kittens.all
    
    # Adding pagination may break some front-end clients
    if smooth_change.enabled?(:kittens_pagination)
      kittens = kittens.page(params[:page])
    end
    
    render json: kittens
  end
end
```

#### In your Models/Service objects
If you want to use this feature flags in your models, call `store_smooth_change`
in a `before_action` callback. This will store the `smooth_change` object in a
`ActiveSupport::CurrentAttributes` (see [Rails documentation](https://docs.w3cub.com/rails~6.0/activesupport/currentattributes))

To access it, call `SmoothChange::Current.smooth_change`. You can also use `enabled?`
direcly with `SmoothChange::Current`

Example:
```ruby
require "smooth_change"

class ApplicationController < ActionController::API
  include SmoothChange::ActionController::Helper

  before_action :store_smooth_change
end

class MyApiController < ActionController::API
  def index
    kittens = ComplexKittenFilter.new(Kitten.all, params).call
    render json: kittens
  end
end

# app/services/complex_kitten_filter.rb
class ComplexKittenFilter < ComplexFilter
  def call
    if SmoothChange::Current.enabled?(:new_kitten_filter)
      filter
    else
      legacy_filter
    end
  end
  
  private
  
  def legacy_filter
    # Do some old-school filtering ...
  end
  
  def filter
    # Filter like the cool kids !
  end
end
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Road Map
* Response helpers
* Instrumentation and Monitoring
* Framework agnostic (remove dependencies from rails and move helpers to dedicated gem)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/smooth_change.
This project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/smooth_change/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SmoothChange project's codebases, issue trackers,
chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/smooth_change/blob/master/CODE_OF_CONDUCT.md).
