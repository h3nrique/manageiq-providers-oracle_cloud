#!/usr/bin/ruby

require 'fog/oraclecloud'
require 'terminal-table'

load 'connect.rb'

## Get shape
def get(name)
    compute = connect()
    data = compute.shapes.get(name)
end

shape = get(ARGV[0])
rows = []
rows << ['Name:', shape.name]
rows << :separator
rows << ['CPUs:', shape.cpus]
rows << :separator
rows << ['GPUs:', shape.gpus]
rows << :separator
rows << ['IO:', shape.io]
rows << :separator
rows << ['Root SSD:', shape.is_root_ssd]
rows << :separator
rows << ['NDS IOPs Limit:', shape.nds_iops_limit]
rows << :separator
rows << ['Placement Requirements:', shape.placement_requirements]
rows << :separator
rows << ['RAM:', shape.ram]
rows << :separator
rows << ['Root Disc Size:', shape.root_disk_size]
rows << :separator
rows << ['SSD Data Size:', shape.ssd_data_size]
rows << :separator
rows << ['URI:', shape.uri]

table = Terminal::Table.new :rows => rows

puts table
