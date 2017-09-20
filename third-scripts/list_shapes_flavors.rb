#!/usr/bin/ruby

require 'fog/oraclecloud'

## List all shapes
def all
    data = Fog::Compute[:oraclecloud].shapes.all
end

shapes = all()
print shapes
