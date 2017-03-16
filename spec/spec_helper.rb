unless ENV['NO_SIMPLECOV']
  require 'simplecov'
  require 'coveralls'

  SimpleCov.start { add_filter '/spec/' }
  Coveralls.wear! if ENV['COVERALLS_REPO_TOKEN']
end

require 'griddler/testing'
require 'griddler/cloudmailin'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.order = 'random'
  config.include Griddler::Testing
end
