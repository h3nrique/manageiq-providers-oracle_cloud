#!/usr/bin/ruby

require 'fog/oraclecloud'

load 'connect.rb'

## Delete instance
def delete(name)
    compute = connect()
    instance = compute.instances.get(name)
    instance.destroy()
end

delete(ARGV[0])
