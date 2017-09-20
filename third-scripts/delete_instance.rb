#!/usr/bin/ruby

require 'fog/oraclecloud'

## Delete instance
def delete(name)
    instance = Fog::Compute[:oraclecloud].instances.get(name)
    instance.destroy()
    instance.wait_for { state == 'stopped' }
end

delete(ARGV[0])
