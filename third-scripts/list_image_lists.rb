#!/usr/bin/ruby

require 'fog/oraclecloud'
require 'terminal-table'

def all
    data = Fog::Compute[:oraclecloud].images.all
end

images = all()

rows = []
images.each { |image| 
    rows << [image.name]
}
table = Terminal::Table.new :headings => ['Name'], :rows => rows

puts table
