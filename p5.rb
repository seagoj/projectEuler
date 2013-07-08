#!/usr/bin/env ruby

require './ProjectEuler.rb'
include ProjectEuler

factors = []
for i in 2..20
    factors = union(factors, factor(i))
end

assertTrue(factors.inject(:*), 232792560)
