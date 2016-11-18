require 'benchmark'
require 'pry'

module Q25
  # module_function

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
    tie_shoes targets.drop(1), [stocks]
    counts.max
  end

  def start_target(holes)
    (0..holes).to_a.repeated_permutation(2).drop(1)
  end

  def tie_shoes(targets, stocks)
  end

  def memo
    @memo ||= []
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

# Benchmark.bm do |x|
#   x.report do
#     $answer = Q25.run
#     $correct = 45
#   end
# end

# puts
# puts "answer : #{$answer}"
# puts "correct : #{$correct}"
