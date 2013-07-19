#!/usr/bin/env ruby

require "./projecteuler.rb"
include ProjectEuler

primes = [2]
total = 0
for i in 2..2000000
    prime = true
    primes.each{ |p|
        prime = false if i%p===0
    }
    if prime
        primes << i
        total += i
        print "#{i}: #{total}\n"
    end
end
