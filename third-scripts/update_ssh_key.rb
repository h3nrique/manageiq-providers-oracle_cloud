#!/usr/bin/ruby

require 'fog/oraclecloud'
require 'terminal-table'

load 'connect.rb'

## Update ssh key
def update(name, enabled, key=nil)
    compute = connect()
    sshKey = compute.ssh_keys.get(name)
    sshKey.enabled = enabled
    if key then
        sshKey.key = key
    end
    sshKey.save()
end

ssh_key = update(ARGV[0], ARGV[1], ARGV[2])

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
