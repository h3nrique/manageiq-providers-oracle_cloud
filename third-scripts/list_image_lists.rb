#!/usr/bin/ruby

require 'fog/oraclecloud'
require 'terminal-table'

load 'connect.rb'

def all
    compute = connect()
    data = compute.images.all
end

images = all()

rows = []
images.each { |image| 
    rows << [image.name]
}
table = Terminal::Table.new :headings => ['Name'], :rows => rows

puts table
