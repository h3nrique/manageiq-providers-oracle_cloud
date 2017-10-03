class ManageIQ::Providers::OracleCloud::CloudManager < ManageIQ::Providers::CloudManager

  require_nested :Flavor

  include ManageIQ::Providers::OracleCloud::ManagerMixin

  alias_attribute :oracle_cloud_domain, :uid_ems

  has_many :resource_groups, :foreign_key => :ems_id, :dependent => :destroy

  supports :discovery
  supports :provisioning
  supports :regions

  before_create :ensure_managers
  before_update :ensure_managers_zone_and_provider_region

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
