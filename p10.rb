#!/usr/bin/env ruby

require "./ProjectEuler.rb"
include ProjectEuler

puts "#{eratosthenesSieve(200000, verbose: true)}\n"

#puts "#{loadField(200, file: 'primes.json')}\n"
