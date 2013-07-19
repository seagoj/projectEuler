#!/usr/bin/env ruby
require 'json'

module ProjectEuler
    def eratosthenesSieve(limit, options={})
        options[:verbose] = false if options[:verbose].nil?
        options[:file] = 'primes.json' if options[:file].nil?

        field = loadField(limit, options)
        lastPrime = JSON.parse(File.read(options[:file])).last

        field.each {|i|
            prime = true
            unless i>Math.sqrt(limit)
                field[1..field.index(i)].each {|j|
                    if i%j===0
                        prime = false
                        coeff=1
                        puts "Removing multiples of #{i}"
                        while coeff*i <= limit do
                            field.delete(coeff*i) unless (coeff*i)===j
                            print "#{coeff*i}/#{limit} - #{100*(coeff*i)/limit}%\n"
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
                field += ((field.last+2)..limit).to_a unless limit<field.last+2
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
                end
            end
        else
            if self.empty?
                prime = nil
            else
                self.flatten.each { |n|
                    for i in 2..n-1
                        prime = false if n%i===0
                    end
                }
            end
        end
        prime
    end

    def factor(number, options={})
        options[:uniq] = true if options[:uniq].nil?
        options[:verbose] = false if options[:verbose].nil?

        puts "#{options}\n" if options[:verbose]

        number = Array(number) unless number.is_a? Array

        factors = []
        number.each do |n|
            for i in 2..n-1
                if n%i===0 && ! factors.prime?
                    if i.prime?
                        factors << i
                        puts "#{i}\n" if options[:verbose]
                    else
                        factors << factor(i, options)
                    end

                    if (n/i).prime?
                        factors << (n/i)
                        puts "#{i}\n" if options[:verbose]
                    else
                        factors << factor(n/i, options)
                    end
                end
                break if factors.prime?
            end
        end
       
        factors = [number] if factors.empty?
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

    def assertEquals(result, answer)
        if result===answer
            print "SUCCESS: "
        else
            print "FAILURE: "
        end

        print result
        result===answer
    end
end
