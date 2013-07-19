#!/usr/bin/env ruby

require "./ProjectEuler.rb"
include ProjectEuler

def sumEven(array)
    sum = 0
    array.each do |n|
        if n.even?
            sum = sum+n
        end
    end
    sum
end

result = fibonacci(4000000)
testAnswer = [1,2,3,5,8,13,21,34,55,89]

puts "\n#{sumEven(result)}" if assertEquals(result[0..9], testAnswer)
