#!/usr/bin/ruby

require 'fog/oraclecloud'
require 'terminal-table'

load 'connect.rb'

## Create instance
def create(name, shape="oc3", imagelist="/oracle/public/oel_6.4_2GB_v1", label, sshkeys, tags)
    compute = connect()
    data = compute.instances.create(
            :name      => name.dup, 
            :shape     => shape, 
            :imagelist => imagelist,
            :label     => label,
            :sshkeys   => [sshkeys],
            :tags      => tags
        )
    data.wait_for { ready? }
end

instance = create(ARGV[0], ARGV[1], ARGV[2], ARGV[3], ARGV[4], ARGV[5])

puts instance

# Example
# ./create_instance.rb "example-instance" "oc3" "/oracle/public/oel_6.4_2GB_v1" "customer-example" "/Compute-a468401/redhat/example-ssh" "[customer,example]"