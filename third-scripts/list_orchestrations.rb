#!/usr/bin/ruby

require 'fog/oraclecloud'
require 'terminal-table'

def all
    data = Fog::Compute[:oraclecloud].orchestrations
end

orchestrations = all()

rows = []
orchestrations.each { |orchestration| 
    rows << [orchestration.name]
}
table = Terminal::Table.new :headings => ['Name'], :rows => rows

puts table
