#!/usr/bin/env ruby

def fibonacci(limit)
    sequence = [1, 2]
    
    length = sequence.length

    while sequence[length-1]+sequence[length-2] < limit do
        sequence << sequence[length-1]+sequence[length-2]
        length = sequence.length
    end
    sequence
end

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
    print "Test Successful\n"
    print sumEven(fibonacci(4000000))
else
    print "Failed"
end

