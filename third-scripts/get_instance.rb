#!/usr/bin/ruby

require 'fog/oraclecloud'
require 'terminal-table'

load 'connect.rb'

## Get image
def get(name)
    compute = connect()
    data = compute.instances.get(name)
end

image = get(ARGV[0])
puts image
rows = []
rows << ['Name:', image.name]
rows << :separator
rows << ['Account:', image.account]
rows << :separator
rows << ['boot_order:', image.boot_order]
rows << :separator
rows << ['disk_attach:', image.disk_attach]
rows << :separator
rows << ['domain:', image.domain]
rows << :separator
rows << ['entry:', image.entry]
rows << :separator
rows << ['error_reason:', image.error_reason]
rows << :separator
rows << ['fingerprint:', image.fingerprint]
rows << :separator
rows << ['hostname:', image.hostname]
rows << :separator
rows << ['hypervisor:', image.hypervisor]
rows << :separator
rows << ['image_format:', image.image_format]
rows << :separator
rows << ['imagelist:', image.imagelist]
rows << :separator
rows << ['ip:', image.ip]
rows << :separator
rows << ['label:', image.label]
rows << :separator
rows << ['networking:', image.networking]
rows << :separator
rows << ['placement_requirements:', image.placement_requirements]
rows << :separator
rows << ['platform:', image.platform]
rows << :separator
rows << ['priority:', image.priority]
rows << :separator
rows << ['quota:', image.quota]
rows << :separator
rows << ['quota_reservation:', image.quota_reservation]
rows << :separator
rows << ['resolvers:', image.resolvers]
rows << :separator
rows << ['reverse_dns:', image.reverse_dns]
rows << :separator
rows << ['shape:', image.shape]
rows << :separator
rows << ['site:', image.site]
rows << :separator
rows << ['sshkeys:', image.sshkeys]
rows << :separator
rows << ['start_time:', image.start_time]
rows << :separator
rows << ['state:', image.state]
rows << :separator
rows << ['storage_attachments:', image.storage_attachments]
rows << :separator
rows << ['tags:', image.tags]
rows << :separator
rows << ['uri:', image.uri]
rows << :separator
rows << ['vcable_id:', image.vcable_id]
rows << :separator
rows << ['virtio:', image.virtio]
rows << :separator
rows << ['vnc:', image.vnc]

table = Terminal::Table.new :rows => rows

puts table
