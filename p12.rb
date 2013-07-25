#!/usr/bin/env ruby
require './ProjectEuler.rb'
include ProjectEuler

class P12
    attr_accessor :triangles

    def initialize
        @triangles = [0]
    end
    
    def nextTriangle(count=nil)
        @triangles << @triangles.last + @triangles.size
        @triangles.last
    end

    def nthTriangle(count)
        count.times do
            nextTriangle()
        end
        @triangles.last
    end
end
    
p12 = P12.new

tri = p12.nthTriangle(8)
while numFactors(tri)<498 do
    tri = p12.nextTriangle()
end
puts tri
