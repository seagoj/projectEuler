#!/usr/bin/env ruby
require_relative "ProjectEuler"
include ProjectEuler

def sumEven(array)
    sum = 0
    array.each do |n|
        sum += n if n.even?
    end
    sum
end

p sumEven(fibonacci(4000000))
