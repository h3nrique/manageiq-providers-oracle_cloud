#!/usr/bin/ruby

require 'fog/oraclecloud'
require 'terminal-table'

load 'connect.rb'

## Create ssh key
def create(name, enabled, key)
    compute = connect()
    data = compute.ssh_keys.create(
            :name       => name.dup,
            :enabled    => enabled,
            :key        => key
        )
end

ssh_key = create(ARGV[0], ARGV[1], ARGV[2])

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
