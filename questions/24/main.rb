require 'benchmark'
require 'pry'

module Q24
  module_function

  NO_STRIKE_OUT_NUM = 5

  def run
    strike_out_count
  end

  def strike_out_count
    @memo = { [] => 1 }
    total_count(get_strike_outs + (1..9).each_cons(1).to_a)
  end

  def total_count(strike_outs)
    @memo[strike_outs] ||=
      count = strike_outs.inject(0) do |acc, p|
        acc + total_count(strike_outs.select { |item| (item & p).empty? })
      end
  end

  def get_strike_outs
    items = (1..9).each_slice(3)
    (get_pairs(items) + get_pairs(items.to_a.transpose)).reject { |p| p.include?(NO_STRIKE_OUT_NUM) }
  end

  def get_pairs(items)
    items.flat_map { |p| p.each_cons(2).to_a }
  end
end

Benchmark.bm do |x|
  x.report do
    $answer = Q24.run
  end
end

puts
puts "answer : #{$answer}"
