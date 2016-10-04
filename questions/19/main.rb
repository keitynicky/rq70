require 'benchmark'
require 'prime'
require "pry"

module Q19
  module_function

  TARGET_COUNT = 6
  SQUARE = 2

  # 写経！
  def run
    # Primeは素数を扱うクラス。そういうのがあるんだね！
    primes = Prime.take(TARGET_COUNT)
    min = primes.last ** SQUARE
    min_friend = []

    primes.permutation{|prime|
      friends = prime.each_cons(2).map{|x, y| x * y}
      friends += [prime.first, prime.last].map{|x| x * x}
      if min > friends.max 
        min = friends.max
        min_friend = friends
      end
    }

    min
  end

end

Benchmark.bm do |x|
  x.report do
    $answer = Q19.run
  end
end

puts
puts "answer : #{$answer}"
