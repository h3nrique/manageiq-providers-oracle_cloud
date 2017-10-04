module ManageIQ::Providers::OracleCloud::ManagerMixin
  extend ActiveSupport::Concern

  def connect(options = {})
    raise MiqException::MiqHostError, _("No credentials defined") if missing_credentials?(options[:auth_type])

    username    = options[:user] || authentication_userid(options[:auth_type])
    password    = options[:pass] || authentication_password(options[:auth_type])
    self.class.raw_connect(username, password, oracle_cloud_domain, hostname)
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
    def raw_connect(username, password, domain, hostname)
      require 'fog/oraclecloud'

      if domain.blank?
        raise MiqException::MiqInvalidCredentialsError, _("Incorrect domain - check your domain")
      end

      Fog::Compute.new({
        provider: 'oraclecloud',
        oracle_username: username,
        oracle_password: password,
        oracle_domain: domain,
        oracle_compute_api: hostname
      })
    end

    # Discovery
    def discover(username, password, domain, hostname)
      new_emses         = []

      all_emses         = includes(:authentications)
      all_ems_names     = all_emses.index_by(&:name)

      new_emses << create_discovered_region("uscom-central-1", username, password, domain, hostname, all_ems_names)

      EmsRefresh.queue_refresh(new_emses) unless new_emses.blank?

      new_emses
    end

    def discover_queue(username, password, domain, hostname)
      MiqQueue.put(
          :class_name  => name,
          :method_name => "discover_from_queue",
          :args        => [username, MiqPassword.encrypt(password), domain, hostname]
      )
    end

    def vms_in_region(compute, region)
      compute.instances()
    end

    def discover_from_queue(username, password, domain, hostname)
      discover(username, MiqPassword.decrypt(password), domain, hostname)
    end

    def create_discovered_region(region_name, username, password, domain, hostname, all_ems_names)

      name = region_name
      name = "#{region_name} #{username}" if all_ems_names.include?(name)
      while all_ems_names.include?(name)
        name_counter = name_counter.to_i + 1 if defined?(name_counter)
        name = "#{region_name} #{name_counter}"
      end

      new_ems = create!(
          :name            => name,
          :provider_region => region_name,
          :zone            => Zone.default_zone,
          :domain         => domain,
          :compute_api    => hostname
      )
      new_ems.update_authentication(
          :default => {
              :userid   => username,
              :password => password
          }
      )
      new_ems
    end
  end
end