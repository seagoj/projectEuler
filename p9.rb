#!/usr/bin/env ruby

for a in 1..1000
    for b in (a+1)..1000
        for c in (b+1)..1000
#            if a+b+c==1000
#                print "#{a}+#{b}+#{c}=#{a+b+c}\n"
#            end
#            if (a**2+b**2)===(c**2)
#                print "#{a**2}+#{b**2}=#{c**2}\n"
#            end
            if a+b+c==1000 && (a**2+b**2)===(c**2)
                print "Found: #{a} + #{b} + #{c} = 1000\n"
            end
        end
    end
end
