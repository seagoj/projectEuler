require './ProjectEuler.rb'
include ProjectEuler

describe ProjectEuler, "#eratosthenesSieve" do
    it "returns all primes less than 20" do
        eratosthenesSieve(20).should eq([2,3,5,7,11,13,17,19])
    end
end

describe ProjectEuler, "#prime?" do
    it "returns true for primeNumber.prime?" do
        7.prime?.should eq(true)
    end

    it "returns false for compositeNumber.prime?" do
        4.prime?.should eq(false)
    end

    it "returns true for an arrayOfPrimes.prime?" do
        [2,3,5,7,11].prime?.should eq(true)
    end

    it "returns false for an arrayContainingNonPrimes.prime?" do
        [2,3,4,5,7,11].prime?.should eq(false)
    end
end

describe ProjectEuler, "#factor" do
    it "returns array of unique prime factors of number" do
        factor(12).should eq([2,3])
    end

    it "returns an array of number of number is prime" do
        factor(2).should eq([2])
    end

    it "returns an array of the union of prime factors of number" do
        factor(12, uniq: false).should eq([2,2,3])
    end
end

describe ProjectEuler, "#leastCommonMultiple" do
    
end

describe ProjectEuler, "#union" do
    
end

describe ProjectEuler, "#nthPrime" do
    
end
