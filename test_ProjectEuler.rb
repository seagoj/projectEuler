#!/usr/bin/env ruby

require './ProjectEuler.rb'
require 'test/unit'
include ProjectEuler

class TestEratosthenesSieve < Test::Unit::TestCase
    def testEratosthenesSieve
        assert_equal(eratosthenesSieve(20), [2,3,5,7,11,13,17,19])
    end
end

