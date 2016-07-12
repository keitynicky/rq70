require 'benchmark'
require 'pry'

module Q13
  module_function

  def run
    count = 0
    # permutationt→要チェック
    (0..9).to_a.permutation do |r, e, a, d, w, i, t, l, k, s|
      next if r == 0 or w == 0 or t == 0 or s == 0
      read = r * 1000 + e * 100 + a * 10 + d
      write = w * 10000 + a * 100 + l * 10 + e
      talk = t * 1000 + a * 100 + l * 10 + k
      skill = s * 10000 + k * 1000 + i * 100 + l * 10 + l
      if read + write + talk == skill then
        count += 1
        puts "#{read} + #{write} + #{talk} + #{skill}"
      end
    end
  end
end

Benchmark.bm do |x|
  x.report do
    $answer = Q12.run
  end
end

puts
puts "answer : #{$answer}"
