module ManageIQ::Providers::OracleCloud::ManagerMixin
  extend ActiveSupport::Concern

  def connect(options = {})
    raise MiqException::MiqHostError, _("No credentials defined") if missing_credentials?(options[:auth_type])

    username    = options[:user] || authentication_userid(options[:auth_type])
    password    = options[:pass] || authentication_password(options[:auth_type])
    self.class.raw_connect(username, password, domain, compute_api)
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
    def raw_connect(username, password, domain, compute_api)
      require 'fog/oraclecloud'

      if domain.blank?
        raise MiqException::MiqInvalidCredentialsError, _("Incorrect domain - check your domain")
      end

      Fog::Compute.new({
        provider: 'oraclecloud',
        oracle_username: username,
        oracle_password: password,
        oracle_domain: domain,
        oracle_compute_api: compute_api
      })
    end

    # Discovery
    def discover(username, password, domain, compute_api)
      new_emses         = []

      all_emses         = includes(:authentications)
      all_ems_names     = all_emses.index_by(&:name)

      known_emses       = all_emses.select { |e| e.authentication_userid == clientid }
      known_ems_regions = known_emses.index_by(&:provider_region)

      compute           = raw_connect(username, password, domain, compute_api)

#      compute.list_locations.each do |region|
#        next if known_ems_regions.include?(region.name)
#        next if vms_in_region(compute, region.name).count == 0 # instances
        # TODO: Check if images are == 0 and if so then skip
#        new_emses << create_discovered_region(region.name, clientid, clientkey, azure_tenant_id, subscription, all_ems_names)
#      end

      # at least create the Azure-eastus region.
      if new_emses.blank? && known_emses.blank?
        new_emses << create_discovered_region("eastus", username, password, domain, compute_api, all_ems_names)
      end

      EmsRefresh.queue_refresh(new_emses) unless new_emses.blank?

      new_emses
    end

    def discover_queue(username, password, domain, compute_api)
      MiqQueue.put(
          :class_name  => name,
          :method_name => "discover_from_queue",
          :args        => [username, MiqPassword.encrypt(password), domain, compute_api]
      )
    end

    def vms_in_region(compute, region)
      compute.instances()
    end

    def discover_from_queue(username, password, domain, compute_api)
      discover(username, MiqPassword.decrypt(password), domain, compute_api)
    end

    def create_discovered_region(region_name, username, password, domain, compute_api, all_ems_names)

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
          :compute_api    => compute_api
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