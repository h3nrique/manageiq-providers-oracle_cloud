$:.push File.expand_path("../lib", __FILE__)

require "manageiq/providers/oracle_cloud/version"

Gem::Specification.new do |s|
  s.name        = "manageiq-providers-oracle_cloud"
  s.version     = ManageIQ::Providers::OracleCloud::VERSION
  s.authors     = ["Paulo Henrique Alves"]
  s.email       = ["alvesph.redhat@gmail.com"]
  s.homepage    = "https://github.com/h3nrique/manageiq-providers-oracle_cloud"
  s.summary     = "OracleCloud Provider for ManageIQ"
  s.description = "OracleCloud Provider for ManageIQ/CloudForms"
  s.licenses    = ["Apache-2.0"]

  s.files = Dir["{app,config,lib}/**/*"]

  s.add_dependency "fog-oraclecloud", "~> 0.1.18"

  s.add_development_dependency "codeclimate-test-reporter", "~> 1.0"
  s.add_development_dependency "simplecov", '~> 1.0'
end
