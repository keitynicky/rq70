require 'benchmark'
require 'pry'

module Q25
  module_function

  # HOLES = 6
  HOLES = 2

  def counts
    @counts ||= []
  end

  def lines
    @liens ||= []
  end

  def run
    binding.pry
    
    # lines_combination.each do |lines|
    #   cross_count lines
    # end
    # counts.max
  end

  def lines_combination
    hoge (0..HOLES).to_a.repeated_permutation(2).drop(1)
    # lines = []
    # lines.push [[0, 1], [1, 0], [1, 2], [2, 1]]
    # lines.push [[1, 0], [1, 1], [2, 1], [2, 2], [0, 2]]
  end

  def hoge _tmp
    _tmp.each do |item|
      targets = _tmp.reject{|i| i == item}
      nexts = targets.select{|i| i.last == item.first}
      nexts.each do |n|

      end
    end
  end

  def moga
    targets = (0..HOLES).to_a.repeated_permutation(2).drop(2)
    stocks = [[0, 0], [0, 1]]
    current = stocks.last
    X.new targets, stocks, current
  end

  def cross_count(l)
    counts.push((l.size - l.count { |line| line.first < line.last }).abs)
  end

  class X < Struct.new :targets, :stocks, :current
    def current_is_same?
      current.first == current.last
    end

    def min_index
      if current_is_same?
      else
        current.first < current.last ? 0 : -1
      end
    end

    def candidates
      if current_is_same?
      else
        targets.reject { |item| item[min_index] == current.min || item == current}
      end
    end
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
