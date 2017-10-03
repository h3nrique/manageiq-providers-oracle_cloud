module ManageIQ::Providers::OracleCloud::ManagerMixin
  extend ActiveSupport::Concern

  def connect(options = {})
    raise MiqException::MiqHostError, _("No credentials defined") if missing_credentials?(options[:auth_type])

    username    = options[:user] || authentication_userid(options[:auth_type])
    password    = options[:pass] || authentication_password(options[:auth_type])
    region      = options[:region] || provider_region
    compute_api = 'https://compute.uscom-central-1.oraclecloud.com/' # TODO :: Update!!!
    storage_api = '<STORAGE_API>' # TODO :: Update!!!
    self.class.raw_connect(username, password, oracle_cloud_domain, region, compute_api, storage_api)
  end

  def verify_credentials(_auth_type = nil, options = {})
    require 'fog/oraclecloud'
    conf = connect(options)
  rescue => err
    _log.error("Error Class=#{err.class.name}, Message=#{err.message}, Backtrace=#{err.backtrace}")
    raise MiqException::MiqInvalidCredentialsError, _("Unexpected response returned from system: #{err.message}")
  else
    conf
  end

  module ClassMethods
    def raw_connect(username, password, domain, region, compute_api, storage_api)
      require 'fog/oraclecloud'

      if domain.blank?
        raise MiqException::MiqInvalidCredentialsError, _("Incorrect domain - check your domain")
      end

      connection = Fog::XML::Connection.new(compute_api)
      connection.request({
        :expects => 204,
        :method  => 'POST',
        :path    => "/authenticate/",
        :headers => {
          'Content-Type' => 'application/oracle-compute-v3+json'
        },
        :body    => Fog::JSON.encode({
           'user' 		 => "/Compute-#{domain}/#{username}",
           'password' => password
         })
      })
    end
  end
end