require 'benchmark'
require 'prime'
require "pry"
# require 'active_support/core_ext/module'　←　便利！要チェック！

module Q19
  module_function

  TARGET_COUNT = 6
  SQUARE = 2
  PAIR = 2

  # 写経！
  def run
    # Primeは素数を扱うクラス。そういうのがあるんだね！[互いに素な数]を取得するために。
    primes = Prime.take(TARGET_COUNT)
    min = primes.last ** SQUARE
    min_friend = []

    # 対象となるデータの順列
    primes.permutation{|prime|
      # ２つの数の掛け算できる数の組み合わせで計算(ここはもう少しシンプルに書けないのかな？injectとか使って。。)
      friends = prime.each_cons(PAIR).map{|x, y| x * y}
      # 先頭と末尾は同じ数の平方
      friends += [prime.first, prime.last].square!
      if min > friends.max 
        min = friends.max
        min_friend = friends
      end
    }

    min
  end

end

class Array
  def square!
    self.map! {|num| num ** SQUARE}
  end
end

Benchmark.bm do |x|
  x.report do
    $answer = Q19.run
  end
end

puts
puts "answer : #{$answer}"
