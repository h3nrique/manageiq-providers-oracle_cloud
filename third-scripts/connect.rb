#!/usr/bin/ruby

require 'fog/oraclecloud'
require 'terminal-table'

## Connect
def connect(fileName)
    options = Hash[*File.read(fileName).split(/[ \n]+/)]
    @username = options['oracle_username']
    @password = options['oracle_password']
    @identity_domain   = options['oracle_domain']
    @api_endpoint   = options['oracle_compute_api']

    @connection = Fog::XML::Connection.new(@api_endpoint)

    @connection.request({
        :expects => 204,
        :method  => 'POST',
        :path    => "/authenticate/",
        :headers => {
            'Content-Type' => 'application/oracle-compute-v3+json'
        },
        :body    => Fog::JSON.encode({
            'user'     => "/Compute-#{@identity_domain}/#{@username}",
            'password' => @password
        })
    })
end

response = connect('credentials.txt')

puts response.headers
