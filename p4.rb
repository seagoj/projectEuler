#!/usr/bin/env ruby

def isPalindrome(n)
    n = n.to_s
    if n.length.even?
        first = n[0..((n.length/2)-1)]
        second = n[n.length/2..n.size]
    else
        first = n[0..((n.length/2).floor)]
        second = n[((n.length/2).floor)..n.size]
    end

    if first === second.reverse
        true
    else
        false
    end
end

pds = []

(100..999).each { |first|
    (100..999).each { |second|
        if isPalindrome(first*second)
            pds << first*second
        end
    }
}

print pds.max

