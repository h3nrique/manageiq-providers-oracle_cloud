#!/usr/bin/ruby

require 'fog/oraclecloud'

load 'connect.rb'

## Delete ssh key
def delete(name)
    compute = connect()
    sshkey = compute.ssh_keys.get(name)
    sshkey.destroy()
end

delete(ARGV[0])
