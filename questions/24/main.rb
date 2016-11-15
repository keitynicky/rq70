require 'benchmark'
require 'pry'

module Q24
  module_function

  def run
    count = (1..9).to_a.permutation.count
    count += strike_out_count
    binding.pry
  end

  def strike_out_count
    0
  end

  def strike_out_pairs
    items = (1..9).each_slice(3)
    (hoge(items) + hoge(items.to_a.transpose)).reject{|p| p.include?(5)}
  end

  def hoge items
    items.map{|p| p.each_cons(2).to_a}.flatten(1)
  end
end

Benchmark.bm do |x|
  x.report do
    $answer = Q24.run
  end
end

puts
puts "answer : #{$answer}"
