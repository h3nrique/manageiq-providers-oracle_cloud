module ManageIQ
  module Providers::OracleCloud
    module Regions
      # The supported regions for the Azure provider. This is used by the UI
      # to display which regions are available when adding a new Azure provider.

      REGIONS = {
        "us1" => {
          :name        => "us1",
          :description => _("US Commercial 1 (us1)"),
        },
        "us2" => {
          :name        => "us2",
          :description => _("US Commercial 2 (us2)"),
        },
        "us6" => {
          :name        => "us6",
          :description => _("US Commercial 6 (us6)"),
        },
        "us8" => {
          :name        => "us8",
          :description => _("US Commercial 8 (us8)"),
        },
        "ap1" => {
          :name        => "ap1",
          :description => _("APAC Commercial 1 (ap1)"),
        },
        "ap2" => {
          :name        => "ap2",
          :description => _("APAC Commercial 2 (ap2)"),
        },
        "ap4" => {
          :name        => "ap4",
          :description => _("APAC Commercial 4 (ap4)"),
        },
        "ap5" => {
          :name        => "ap5",
          :description => _("APAC Commercial 5 (ap5)"),
        },
        "ca2" => {
          :name        => "ca2",
          :description => _("CA Commercial 2 (ca2)"),
        },
        "ca3" => {
          :name        => "ca3",
          :description => _("CA Commercial 3 (ca3)"),
        },
        "em1" => {
          :name        => "em1",
          :description => _("EMEA Commercial 1 (em1)"),
        },
        "em2" => {
          :name        => "em2",
          :description => _("EMEA Commercial 2 (em2)"),
        },
        "em3" => {
          :name        => "em3",
          :description => _("EMEA Commercial 3 (em3)"),
        },
        "em4" => {
          :name        => "em4",
          :description => _("EMEA Commercial 4 (em4)"),
        },
        "la1" => {
          :name        => "la1",
          :description => _("LAD Commercial 1 (la1)"),
        },
        "US" => {
          :name        => "US",
          :description => _("Public Cloud Services - US"),
        },
        "EMEA" => {
          :name        => "EMEA",
          :description => _("Public Cloud Services - EMEA"),
        },
      }.freeze

      # Returns an array of hashes corresponding to the REGIONS hash, excluding
      # disabled regions.
      #
      def self.regions
        REGIONS
      end

      # Returns an array of hashes corresponding to the REGIONS hash. Unlike
      # the +regions+ method, this only includes the values hash i.e. :name
      # and :description.
      #
      def self.all
        regions.values
      end

      # Return a simple array of region names. These correspond to the keys
      # in the REGIONS hash.
      #
      def self.names
        regions.keys
      end

      # Returns a hash containing :name and :description for region +name+.
      #
      # Example:
      #
      #   instance.find_by_name('eastus') # => {:name => 'eastus', :description => 'East US'}
      #
      def self.find_by_name(name)
        regions[name]
      end
    end
  end
end
