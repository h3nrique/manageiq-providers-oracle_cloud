class ManageIQ::Providers::OracleCloud::CloudManager < ManageIQ::Providers::CloudManager

  require_nested :Flavor

  def ensure_network_manager
    build_network_manager(:type => 'ManageIQ::Providers::OracleCloud::NetworkManager') unless network_manager
  end

  def self.ems_type
    @ems_type ||= "oraclecloud".freeze
  end

  def self.description
    @description ||= "OracleCloud".freeze
  end

  def description
    ''
    #ManageIQ::Providers::OracleCloud::Regions.find_by_name(provider_region)[:description]
  end
end
