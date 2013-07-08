#!/usr/bin/env ruby

require "./ProjectEuler.rb"
include ProjectEuler

puts "#{eratosthenesSieve(2000000).inject(:+)}\n"
