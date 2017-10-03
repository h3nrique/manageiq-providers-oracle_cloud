#!/usr/bin/ruby

require 'fog/oraclecloud'
require 'terminal-table'

load 'connect.rb'

## Get orchestration
def get(name)
    compute = connect()
    data = compute.orchestrations.get(name)
end

orchestration = get(ARGV[0])
rows = []
rows << ['URI:', orchestration.uri]
rows << :separator
rows << ['Account:', orchestration.account]
rows << :separator
rows << ['Description:', orchestration.description]
rows << :separator
rows << ['Info:', orchestration.info]
rows << :separator
rows << ['O Plans:', orchestration.oplans]
rows << :separator
rows << ['Relationships:', orchestration.relationships]
rows << :separator
rows << ['Schedule:', orchestration.schedule]
rows << :separator
rows << ['Status:', orchestration.status]
rows << :separator
rows << ['Status Timestamp:', orchestration.status_timestamp]
rows << :separator
rows << ['User:', orchestration.user]
rows << :separator
rows << ['Name:', orchestration.name]

table = Terminal::Table.new :rows => rows

puts table
