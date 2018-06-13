require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr'
  config.hook_into :typhoeus
  config.allow_http_connections_when_no_cassette = true
end
