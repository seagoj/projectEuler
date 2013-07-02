#!/usr/bin/env ruby

include ProjectEuler

print "#{eratosthenesSieve(2000000).inject(:+)}\n"
