#!/usr/bin/env ruby
require './ProjectEuler.rb'
include ProjectEuler

def collatz(n, sequence=[n])

    if n%2==0
        n = n/2
    else
        n = 3*n+1
    end

    sequence << n
    if n==1
        sequence
    else
        collatz(n, sequence)
    end
end

solution = {number:0, length:0}

for try in (1..999999) do
    size = collatz(try).size
    if size > solution[:length]
        solution = {number: try, length: size}
    end
end

# 837799
puts solution[:number]


    
