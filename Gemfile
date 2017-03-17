source 'https://rubygems.org'

gem 'griddler', github: 'thoughtbot/griddler' # So as to include the spec folder
gem 'nokogiri', (RUBY_VERSION < '2' ? '< 1.7' : '> 0') # Nokogiri >= 1.7 requires Ruby 2+

gemspec

group :development do
  gem 'bundler'
  gem 'gem-release'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-rubocop'
end

group :test do
  gem 'coveralls'
  gem 'fuubar'
  gem 'rspec'
  gem 'rspec_junit_formatter'
  gem 'simplecov', '~> 0.13'
end
