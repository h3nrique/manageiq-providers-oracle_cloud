$:.push File.expand_path("../lib", __FILE__)

require "manageiq/providers/oraclecloud/version"

Gem::Specification.new do |s|
  s.name        = "manageiq-providers-oraclecloud"
  s.version     = ManageIQ::Providers::OracleCloud::VERSION
  s.authors     = ["Paulo Henrique Alves"]
  s.email       = ["alvesph.redhat@gmail.com"]
  s.homepage    = "https://github.com/ManageIQ/manageiq-providers-oraclecloud"
  s.summary     = "OracleCloud Provider for ManageIQ"
  s.description = "OracleCloud Provider for ManageIQ/CloudForms"
  s.licenses    = ["Apache-2.0"]

  s.files = Dir["{app,config,lib}/**/*"]

  s.add_dependency "fog-oraclecloud", "~> 0.1.17" # FIXME :: Usar versão 0.1.18, aguardando owner do fog-oraclecloud atualizar o projeto no rubygems.org.

  s.add_development_dependency "codeclimate-test-reporter", "~> 1.0"
  s.add_development_dependency "simplecov", '~> 1.0'
end
