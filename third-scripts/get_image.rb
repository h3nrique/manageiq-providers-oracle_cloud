#!/usr/bin/ruby

require 'fog/oraclecloud'
require 'terminal-table'

load 'connect.rb'

## Get image
def get(name)
    compute = connect()
    data = compute.images.get_public(name)
end

image = get(ARGV[0])
rows = []
rows << ['Name:', image.name]
rows << :separator
rows << ['Account:', image.account]
rows << :separator
rows << ['Sizes:', image.sizes]
rows << :separator
rows << ['Hypervisor:', image.hypervisor]
rows << :separator
rows << ['URI:', image.uri]
rows << :separator
rows << ['Quota:', image.quota]
rows << :separator
rows << ['Platform:', image.platform]
rows << :separator
rows << ['No Upload:', image.no_upload]
rows << :separator
rows << ['State:', image.state]
rows << :separator
rows << ['Signed By:', image.signed_by]
rows << :separator
rows << ['File:', image.file]
rows << :separator
rows << ['Signature:', image.signature]
rows << :separator
rows << ['Checksums:', image.checksums]
rows << :separator
rows << ['Error Reason:', image.error_reason]
rows << :separator
rows << ['Image Format:', image.image_format]
rows << :separator
rows << ['Audited:', image.audited]

table = Terminal::Table.new :rows => rows

puts table
