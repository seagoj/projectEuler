#!/usr/bin/env ruby

require './ProjectEuler.rb'
include ProjectEuler

def sumMultiples(number1, number2, limit)
    multiples = []

    for i in 1..(limit-1)
        if i%number1===0 || i%number2===0
            multiples << i
        end
    end
    multiples.inject(:+)
end

assertTrue(sumMultiples(3, 5, 1000), 233168)
