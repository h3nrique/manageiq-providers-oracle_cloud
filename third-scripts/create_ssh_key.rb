#!/usr/bin/ruby

require 'fog/oraclecloud'
require 'terminal-table'

load 'connect.rb'

## Create ssh key
def create(name, enabled, key)
    compute = connect()
    data = compute.ssh_keys.create(
            :name       => name.dup,
            :enabled    => enabled,
            :key        => key
        )
end

ssh_key = create(ARGV[0], ARGV[1], ARGV[2])

rows = []
rows << ['Name:', ssh_key.name]
rows << :separator
rows << ['URI:', ssh_key.uri]
rows << :separator
rows << ['Enabled:', ssh_key.enabled]
rows << :separator
rows << ['Key:', ssh_key.key]
rows << :separator

table = Terminal::Table.new :rows => rows

puts table

# Example
# ./create_ssh_key.rb "example-ssh" "true" "AAAAB3NzaC1yc2EAAAADAQABAAACAQCo2+FmHYW3zK6vBsdVdB291vFcxcZ/IWCfMx/AVmDadodYPnDTK2D2/6rD7SiA7884awLLoisMWFx5J1RVoRRbw/NPwUC/LgmEEhxLemfG1SFiMlBC3ihEn5T+FaWoRTdZBkO5jXuPkt9cMVA4z5y6LRIw6Ny8ZUfhMFvhNGnCMEeghUF3M8D79f/a7VOSQqcHxJXotEnq+jani+vVT0pNkX51fPPU7bhHxJ5AdXDi5Ni0/FXtZI1P7JXoixisfz4oP3MxeAZ6OfL2mxqxQGRZVN3bM2jzFt4othZBReN4gTLqHlXe2/7yRf/uSCqMUBaBCBMSai9IiU4Il87df2bgEKRNKHheNROYdJjOKpjYDYLvU6jYOd7V1g96UlsWwlnjfSlS5FEWR0XnZGUvFIm3oIR6tT0PfdoXW8BvJx0eAJUbeamA1/Bib4XtXVY+2qBbcXn7nvJQLg8UOB9+K+fpNqX7oODGwz6anUN+T+FpsxBMV2+NZyzeRk9Ppohiq80/lIDUL5kpJh9uyCJjh8+BHcEsQfGDxcDZrQ6gplYULDvqTTreZpx7Q5s2Xoc4pvZWI2ACEm2h61MYrKoNT90tnF9f2dO+1GXV+Z++5D6Qo0eSTSFNrHxNCcdIgY8qTJ49dVi1VGIFED43DtD77k1Wutk148ZRcVBCF+ELgh/JEw=="