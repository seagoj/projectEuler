#!/usr/bin/env ruby

def primeFactor(n, suppress=false)
    primeFactors = []
    for i in 2..(n-1)
        if n%i===0
            if !suppress
                print "Found factor: #{i}"
            end
            if primeFactor(i, true).empty?
                if !suppress
                    print ": PRIME!\n"
                end
                primeFactors << i
            else
                if !suppress
                    print ": not prime\n"
                end
            end
        end
    end
    primeFactors
end

print primeFactor(600851475143).last
