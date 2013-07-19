#!/usr/bin/env ruby

module ProjectEuler
    def eratosthenesSieve(limit)
        field = (2..limit).to_a
    
        field.each {|i|
            unless i>Math.sqrt(limit)
                field[0..field.index(i)].each {|j|
                    if i%j===0
                        coeff=1
                        while coeff*i <= limit do
                            field.delete(coeff*i) unless (coeff*i)===j
                            coeff += 1
                        end
                    end
                }
            end
        }
    end

    def prime?
        prime = true

        if !self.is_a? Array
            for i in 2..Math.sqrt(self)
                if self%i===0
                    prime = false
                end
            end
        else
            if self.empty?
                prime = nil
            else
                self.flatten.each do |n|
                    for i in 2..n-1
                        if n%i===0
                            prime = false
                        end
                    end
                end
            end
        end
        prime
    end

    def factor(number, options={})
        options[:uniq] = true if options[:uniq].nil?
        number = Array(number) unless number.is_a? Array

        factors = []
        number.each do |n|
            for i in 2..n-1
                if n%i===0 && !factors.prime?
                    if i.prime?
                        factors << i
                    else
                        factors << factor(i, options)
                    end

                    if (n/i).prime?
                        factors << (n/i)
                    else
                        factors << factor(n/i, options)
                    end
                end
            end
        end
       
        factors = [number] if factors.empty?
        factors = factors.uniq if options[:uniq]
        puts options[:uniq]
        puts factors
        factors.flatten.sort
    end

    def leastCommonMultiple(n)
        factors = []
        if n.is_a? Range
            for i in n
                factors = union(factors, factor(i, uniq:false))
            end
        else
            if n.is_a? Array
                n.each do |j|
                    factors = union(factors, factor(j, uniq:false))
                end
            else
                factors = factor(j, uniq:false)
            end

        end
        factors.inject(:*)
    end

    def union(array1, array2)
        res = []
        combination = array1 + array2
        combination.uniq.each do |elem|
            [array1.count(elem), array2.count(elem)].max.times do
                res << elem    
            end
        end
        res.sort
    end

    def nthPrime(n)
        primes = [2]
        test = primes.last+1

        while primes.length<n do
            prime = true
            primes.each { |p|
                if p > Math.sqrt(test)
                    break
                else
                    if test%p===0
                        prime = false
                        break
                    end
                end
            }
            primes << test if prime
            
            test += 1
        end
        
        primes.last
    end
end
