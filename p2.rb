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

if(fibonacci(4000000)[0..9] == [1,2,3,5,8,13,21,34,55,89])
    puts "Test Successful\n"
    puts sumEven(fibonacci(4000000))
else
    puts "Failed"
end

