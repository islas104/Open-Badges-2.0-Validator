source "https://rubygems.org"

gem "rails", "~> 8.0.2"
gem "propshaft"
gem "sqlite3", ">= 2.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"

# For fetching remote badge data
gem "httparty"

# For parsing JSON-LD (if needed)
gem "json-ld"

# Database-backed adapters for caching, job processing, etc.
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

# CSS bundling (using Rails' recommended approach)
gem "cssbundling-rails"

group :test do
  gem "rspec-rails"
  gem "capybara"
  gem "selenium-webdriver"
end

group :development, :test do
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end
