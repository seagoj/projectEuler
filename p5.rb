#!/usr/bin/env ruby

found = false
start = 1

while !found do
    print "Checking #{start}"
    found = true
    (1..20).each {|n|
        unless start%n===0
            found = false
        end
    }
    if found
        print ": FOUND!\n"
    else
        print ": not found\n"
        start = start+1
    end
end
