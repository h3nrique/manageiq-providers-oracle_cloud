#!/usr/bin/ruby

require 'fog/oraclecloud'
require 'terminal-table'

## Connect
def connect(fileName = 'credentials.txt')
    options = Hash[*File.read(fileName).split(/[ \n]+/)]

    Fog::Compute.new({
        provider: 'oraclecloud',
        oracle_username: options['oracle_username'],
        oracle_password: options['oracle_password'],
        oracle_domain: options['oracle_domain'],
        oracle_compute_api: options['oracle_compute_api']
    })
end
