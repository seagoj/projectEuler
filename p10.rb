#!/usr/bin/env ruby

require "./projecteuler.rb"
include ProjectEuler

puts "#{eratothenesSieve(2000000).inject(:+)}\n"
