#!/usr/bin/ruby

require 'fog/oraclecloud'
require 'terminal-table'

load 'connect.rb'

## List all ssh keys
def all
    compute = connect()
    ssh_keys = compute.ssh_keys

    rows = []
    ssh_keys.each { |ssh_key| 
        rows << [ssh_key.name, ssh_key.enabled]
    }
    data = rows
end

rows = all()
table = Terminal::Table.new :headings => ['Nome', 'Enabled'], :rows => rows

puts table
