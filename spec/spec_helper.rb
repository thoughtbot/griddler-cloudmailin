require 'griddler/testing'
require 'griddler/cloudmailin'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.order = 'random'
  config.include Griddler::Testing
end
