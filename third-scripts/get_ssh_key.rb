#!/usr/bin/ruby

require 'fog/oraclecloud'
require 'terminal-table'

## Get ssh key
def get(name)
    data = Fog::Compute[:oraclecloud].ssh_keys.get(name)
end

ssh_key = get(ARGV[0])
rows = []
rows << ['Name:', ssh_key.name]
rows << :separator
rows << ['URI:', ssh_key.uri]
rows << :separator
rows << ['Enabled:', ssh_key.enabled]
rows << :separator
rows << ['Key:', ssh_key.key]
rows << :separator

table = Terminal::Table.new :rows => rows

puts table
