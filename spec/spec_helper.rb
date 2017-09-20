if ENV['CI']
  require 'simplecov'
  SimpleCov.start
end

VCR.configure do |config|
  config.ignore_hosts 'codeclimate.com' if ENV['CI']
  config.cassette_library_dir = File.join(ManageIQ::Providers::OracleCloud::Engine.root, 'spec/vcr_cassettes')
end

Dir[Rails.root.join("spec/shared/**/*.rb")].each { |f| require f }
Dir[ManageIQ::Providers::OracleCloud::Engine.root.join("spec/support/**/*.rb")].each { |f| require f }
