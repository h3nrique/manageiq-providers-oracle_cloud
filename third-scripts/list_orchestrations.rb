#!/usr/bin/ruby

require 'fog/oraclecloud'
require 'terminal-table'

load 'connect.rb'

def all
    compute = connect()
    data = compute.orchestrations
end

orchestrations = all()

rows = []
orchestrations.each { |orchestration| 
    rows << [orchestration.name]
}
table = Terminal::Table.new :headings => ['Name'], :rows => rows

puts table
