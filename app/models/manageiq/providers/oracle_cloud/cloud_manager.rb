class ManageIQ::Providers::OracleCloud::CloudManager < ManageIQ::Providers::CloudManager

  require_nested :Flavor

  alias_attribute :azure_tenant_id, :uid_ems

  has_many :resource_groups, :foreign_key => :ems_id, :dependent => :destroy

  supports :discovery
  supports :provisioning
  supports :regions

  def ensure_network_manager
    build_network_manager(:type => 'ManageIQ::Providers::OracleCloud::NetworkManager') unless network_manager
  end

  def self.ems_type
    @ems_type ||= "oracle_cloud".freeze
  end

  def self.description
    @description ||= "Oracle Cloud".freeze
  end

  def description
    ManageIQ::Providers::OracleCloud::Regions.find_by_name(provider_region)[:description]
  end
end
