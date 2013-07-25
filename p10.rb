#!/usr/bin/env ruby

require "./ProjectEuler.rb"
include ProjectEuler

puts "#{atkinsSieve(2000000).inject(:+)}\n"
