#!/usr/bin/ruby

require 'fog/oraclecloud'

load 'connect.rb'

## Delete instance
def delete(name)
    compute = connect()
    instance = compute.instances.get(name)
    instance.destroy()
    instance.wait_for { state == 'stopped' }
end

delete(ARGV[0])
