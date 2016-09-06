require 'benchmark'

module Q15
  module_function
  N = 10
  STEPS = 4
  @memo = {}

  # 再帰をつかったやり方
  def run
    move(0, N)
  end

  def move(a, b)
    return 0 if a > b
    return 1 if a == b
    count = 0
    (1..STEPS).each{|da|
      (1..STEPS).each{|db|
        count += move(a + da, b - db)
      }
    }
    count
  end

  # 高速処理(メモ化を利用)
  def run2
    move2(0, N)
  end

  def move2(a, b)
    return @memo[[a,b]] if @memo.has_key?([a, b])
    return @memo[[a,b]] = 0 if a > b
    return @memo[[a,b]] = 1 if a == b
    count = 0
    (1..STEPS).each{|da|
      (1..STEPS).each{|db|
        count += move2(a + da, b - db)
      }
    }
    @memo[[a,b]] = count
  end
end

Benchmark.bm do |x|
  x.report do
    $answer = Q15.run2
  end
end

puts
puts "answer : #{$answer}"
