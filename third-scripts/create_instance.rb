#!/usr/bin/ruby

require 'fog/oraclecloud'
require 'terminal-table'

## Create instance
def create(name, shape="oc3", imagelist="/oracle/public/oel_6.4_2GB_v1", label, sshkeys)
    data = Fog::Compute[:oraclecloud].instances.create(
            :name      => name.dup, 
            :shape     => shape, 
            :imagelist => imagelist,
            :label     => label,
            :sshkeys   => [sshkeys]
        )
    data.wait_for { ready? }
end

instance = create(ARGV[0], ARGV[1], ARGV[2], ARGV[3], ARGV[4])

puts instance
