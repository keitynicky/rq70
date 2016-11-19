require 'benchmark'
require 'pry'

module Q25
  module_function

  # HOLES = 6
  HOLES = 2

  def counts
    @counts ||= []
  end

  def run
    binding.pry
    # max_cross_count
  end

  def max_cross_count
    targets = start_target HOLES
    stocks = targets.first
    counts.max
  end

  def start_target(holes)
    (0..holes).to_a.repeated_permutation(2).drop(1)
  end

  def memo
    @memo ||= []
  end

  def test
      x = [0,1,2].repeated_permutation(2).to_a.drop(1)
      start_ls = x.select {|item| item.first.zero?}
      end_rs = x.select {|item| item.last.zero?}
      candidates = x - (start_ls + end_rs)
      start_ls.each do |item|
        test2 item, candidates, [], -1
      end
      binding.pry      
  end

  def test2 current, candidates, x, index
    if candidates.empty?
      memo << x
    else
      next_c = candidates - [current]
      cand = next_c.select{ |item| item[index] == current[index] }
      cand.each do |y|
        x << y
        test2 y, next_c, x, index == 0 ? -1 : 0
      end
    end
  end

  def hoge
    tmp = []
    tmp << [0].product([1,2]).first
    tmp << [1,2].product([1]).first
    tmp << [1].product([2]).first
    tmp << [2].product([2]).first
    tmp << [2].product([0]).first
  end

  def fuga
    tmp = []
    tmp << [0].product([1,2]).last
    tmp << [1,2].product([2]).first
    tmp << [1].product([1]).first
    tmp << [2].product([1]).first
    tmp << [2].product([0]).first
  end

  def moga
    tmp = []
    tmp << [0].product([1,2]).first
    tmp << [1,2].product([1]).last
    tmp << [2].product([2]).first
    tmp << [1].product([2]).first
    tmp << [1].product([0]).first
  end

  def cross_count(l)
    l.each do |item|
      x = Counter.new item
      tmp = l.drop(1)
      unless x.except?
        tmp.each do |input|
          if x.crossing? input
            memo.push x.cross_pair
          end 
        end
      end
    end
    memo.uniq.count
  end
end

class Counter < Struct.new :item

  def min_index
    item.min == item.first ? 0 : -1
  end

  def max_index
    item.max == item.first ? 0 : -1
  end

  def except?
    item.uniq.one?
  end

  def crossing? _input
    @input = _input
    _input[min_index] > item.min && _input[max_index] < item.max
  end

  def cross_pair
    [item, @input].sort
  end

end

Benchmark.bm do |x|
  x.report do
    $answer = Q25.run
    $correct = 45
  end
end

puts
puts "answer : #{$answer}"
puts "correct : #{$correct}"
