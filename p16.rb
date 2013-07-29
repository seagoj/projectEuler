#!/usr/bin/env ruby
require './ProjectEuler.rb'
include ProjectEuler

puts "#{(2**1000).to_s.split("").collect{|s| s.to_i}.inject(:+)}\n"
