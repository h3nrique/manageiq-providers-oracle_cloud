#!/usr/bin/ruby

require 'fog/oraclecloud'
require 'terminal-table'

## List all instances
def all
    data = Fog::Compute[:oraclecloud].ip_networks.all
end

instances = all()
puts instances
#rows = []
#instances.each { |instance| 
#    rows << [instance.name, instance.platform, instance.state]
#}
#table = Terminal::Table.new :headings => ['Name', 'Platform', 'State'], :rows => rows

#puts table
