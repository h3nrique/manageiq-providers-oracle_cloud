#!/usr/bin/ruby

require 'fog/oraclecloud'
require 'terminal-table'

load 'connect.rb'

## List all instances
def all
    compute = connect()
    data = compute.ip_networks.all
end

instances = all()
puts instances
#rows = []
#instances.each { |instance| 
#    rows << [instance.name, instance.platform, instance.state]
#}
#table = Terminal::Table.new :headings => ['Name', 'Platform', 'State'], :rows => rows

#puts table
