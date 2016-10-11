require 'benchmark'
require "pry"

module Q20
  module_function
  
  FACADE_OF_THE_PASSION = [1,14,14,4,11,7,6,9,8,10,10,5,13,2,3,15]

  def run
    combination_count = Hash.new(0)
    (1..FACADE_OF_THE_PASSION.length).each{|i|
      FACADE_OF_THE_PASSION.combination(i).each{|items|
        tmp = items.inject(:+)
        combination_count[tmp] += 1
      }
    }
    largest_hash_key combination_count
  end

  def largest_hash_key(hash)
    hash.max_by{|k,v| v}
  end

end

Benchmark.bm do |x|
  x.report do
    $answer = Q20.run
  end
end

puts
puts "answer : #{$answer}"
