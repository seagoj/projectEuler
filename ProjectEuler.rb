#!/usr/bin/env ruby
require 'json'

module ProjectEuler
    def eratosthenesSieve(limit, options={})
        options[:verbose] = false if options[:verbose].nil?
        options[:file] = 'primes.json' if options[:file].nil?

        field = loadField(limit, options)
        lastPrime = JSON.parse(File.read(options[:file])).last if File.exists?(options[:file])
        lastPrime = 2 if lastPrime.nil?

        field.each {|i|
            prime = true
            unless i>Math.sqrt(limit)
                field[1..field.index(i)].each {|j|
                    if i%j===0
                        prime = false
                        coeff=1
                        puts "Removing multiples of #{i}" if options[:verbose]
                        while coeff*i <= limit do
                            field.delete(coeff*i) unless (coeff*i)===j
                            print "#{i}: #{coeff*i}/#{limit} - #{100*(coeff*i)/limit}%\n" if options[:verbose]
                            coeff += 1
                        end
                    end
                }
            end

            knownPrimes = field[0..field.index(i)]
            File.open(options[:file], 'w') { |f| f.write(knownPrimes.to_json) } if prime && i>lastPrime
        }
    end

    def loadField(limit, options)
        options[:file] = 'primes.json' if options[:file].nil?
        if File.exists?(options[:file])
            field = JSON.parse(File.read(options[:file]))

            ret = []

            field.each{ |n|
                if n <=limit
                    ret << n
                else
                    break;
                end
            }
            
            field = ret

            if field.prime?
                field += ((field.last+2)..limit).step(2).to_a unless limit<field.last+2
            else
                field = (2..limit).to_a
            end
        else
            field = [2]
            field += (3..limit).step(2).to_a
        end
        field
    end

    def fibonacci(limit)
        sequence = [1, 2]
 
        length = sequence.length

        while sequence[length-1]+sequence[length-2] < limit do
            sequence << sequence[length-1]+sequence[length-2]
            length = sequence.length
        end
        sequence
    end

    def prime?
        prime = true

        if !self.is_a? Array
            for i in 2..Math.sqrt(self)
                if self%i===0
                    prime = false
#                    puts "#{self} is not prime"
                end
            end
        else
            if self.empty?
                prime = nil
            else
                self.flatten.each { |n|
                    unless n.nil?
                        for i in 2..n-1
                            if n%i===0
                                prime = false
#                                puts "#{n} is not prime"
                            end
                        end
                    end
                }
            end
        end
        prime
    end

    def factor(number, options={})
        options[:uniq] = true if options[:uniq].nil?
        options[:verbose] = false if options[:verbose].nil?
        options[:prime] = true if options[:prime].nil?

        puts "#{options}\n" if options[:verbose]

        number = Array(number) unless number.is_a? Array

        factors = []
        number.each do |n|
            for i in 2..n-1
                if n%i===0 && (!options[:prime] || !factors.prime?)
                    if !options[:prime] || i.prime?
                        factors << i
                        puts "#{i}\n" if options[:verbose]
                    else
                        factors << factor(i, options) if options[:prime]
                    end

                    if !options[:prime] || (n/i).prime?
                        factors << (n/i)
                        puts "#{i}\n" if options[:verbose]
                    else
                        factors << factor(n/i, options) if options[:prime]
                    end
                end
                break if factors.prime?
            end
        end
       
        factors = [number] if factors.empty?
        factors = factors.compact.flatten.sort

        return (options[:uniq] ? factors.uniq : factors)
    end

    def numFactors(number, options={})
        primeFactors = factor(number, uniq:false)
        count = {}
        count.default = 0
        factors = 1

        primeFactors.each do |p|
            count[p] += 1
        end

        count.each do |k,v|
            factors *= (v+1)
        end

        factors
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

    def atkinsSieve(limit, options={})
        options[:verbose] = false if options[:verbose].nil?

        result = [2,3,5]
        lastSpecialCase = result.last

        field = {}
        field.default = false

        # Toggle prime status if n meets any of the conditions below
        # 1: n=4x^2+y^2 and n%12=1 or n%12=5
        # 2: n=3x^2+y^2 and n%12=7
        # 3: n=3x^2-y^2 and x>y and n%12=11
        for x in 1..Math.sqrt(limit)
            for y in 1..Math.sqrt(limit)
                n = 4*(x**2)+(y**2)
                mod12 = n%12
                if (n>lastSpecialCase) && (n<=limit) && (mod12==1 || mod12==5)
                    field[n] = !field[n]
                end

                n = 3*(x**2)+(y**2)
                mod12 = n%12
                if (n>lastSpecialCase) && (n<=limit) && (mod12==7)
                    field[n] = !field[n]
                end

                n = 3*(x**2)-(y**2)
                mod12 = n%12
                if (n>lastSpecialCase) && (x>y) && (n<=limit) && (mod12==11)
                    field[n] = !field[n]
                end
            end
        end

        # Mark multiples of prime^2 as composite
        (lastSpecialCase..Math.sqrt(limit)).each{ |n|
            coeff = 1
            while coeff*(n**2) < limit do
                field[coeff*(n**2)] = false
                coeff += 1
            end
        }
        
        # Move primes to return variable    
        field.each { |n, status|
            result << n if status    
        }
        result
    end

    # returns number of possible paths of length x,y on a grid moving in only one
    # vertical direction and one horizontal direction
    def latticePath(x, y)
        (x+y).choose(y)
    end

    def factorial(n)
        product = 1;
        (2..n).each do |f|
            product *= f
        end
        product
    end

    def choose(k)
        factorial(self)/(factorial(self-k)*factorial(k))
    end
end
