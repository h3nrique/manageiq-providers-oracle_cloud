class ManageIQ::Providers::OracleCloud::NetworkManager < ManageIQ::Providers::NetworkManager
  require_nested :FloatingIp

  # include ManageIQ::Providers::OracleCloud::ManagerMixin

  has_many :floating_ips, :foreign_key => :ems_id, :dependent => :destroy,
           :class_name => ManageIQ::Providers::OracleCloud::NetworkManager::FloatingIp

  def self.ems_type
    @ems_type ||= "oraclecloud_network".freeze
  end

  def self.description
    @description ||= "OracleCloud Network".freeze
  end

  def self.hostname_required?
    false
  end

  def description
    ManageIQ::Providers::OracleCloud::Regions.find_by_name(provider_region)[:description]
  end
end
