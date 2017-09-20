#!/usr/bin/ruby

require 'fog/oraclecloud'

## Delete ssh key
def delete(name)
    sshkey = Fog::Compute[:oraclecloud].ssh_keys.get(name)
    sshkey.destroy()
end

delete(ARGV[0])
