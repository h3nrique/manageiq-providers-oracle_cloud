#!/usr/bin/ruby

require 'fog/oraclecloud'

load 'connect.rb'

## List all shapes
def all
    compute = connect()
    data = compute.shapes.all
end

shapes = all()
print shapes
