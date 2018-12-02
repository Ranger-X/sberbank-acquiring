source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'jruby-openssl', platforms: :jruby
gem 'rake'
#gem 'yard'
gem 'rack'

group :test do
  gem 'rspec'
  gem 'rubocop'
  gem 'webmock'
#  gem 'yardstick'
#  gem 'rspec-its'
  gem 'minitest-color'
end

# Specify your gem's dependencies in sberbank-acquiring.gemspec
gemspec
