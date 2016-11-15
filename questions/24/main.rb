require 'benchmark'
require 'pry'

module Q24
  module_function

  NO_STRIKE_OUT_NUM = 5

  def run
    count = (1..9).to_a.permutation.count
    count += strike_out_count
    binding.pry
  end

  def strike_out_count
    0
  end

  def all_strike_out_pairs
    items = (1..9).each_slice(3)
    (strike_out_pairs(items) + strike_out_pairs(items.to_a.transpose)).reject { |p| p.include?(NO_STRIKE_OUT_NUM) }
  end

  def strike_out_pairs(items)
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
