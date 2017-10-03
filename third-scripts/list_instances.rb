#!/usr/bin/ruby

require 'fog/oraclecloud'
require 'terminal-table'

load 'connect.rb'

## List all instances
def all
    compute = connect()
    data = compute.instances
end

instances = all()
rows = []
instances.each { |instance| 
    rows << [instance.name, instance.platform, instance.state]
}
table = Terminal::Table.new :headings => ['Name', 'Platform', 'State'], :rows => rows

puts table
