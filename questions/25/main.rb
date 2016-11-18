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
    # binding.pry
    max_cross_count
  end

  def max_cross_count
    targets = (0..HOLES).to_a.repeated_permutation(2).drop(1)
    stocks = targets.first
    tie_ones_shoes targets.drop(1), [stocks]
    counts.max
  end

  def tie_ones_shoes(targets, stocks)
    tmp = Stocker.new targets, stocks
    if tmp.completed?
      cross_count tmp.stocks
    else
      current = tmp.candidates.first
      tie_ones_shoes(tmp.candidates.drop(1), tmp.stocks.push(current))
    end
  end

  def cross_count(l)
    counts.push((l.size - l.count { |line| line.first < line.last }).abs)
  end

  class Stocker < Struct.new :targets, :stocks
    def current
      stocks.last
    end

    def completed?
      candidates.empty?
    end

    def current_is_same?
      current.first == current.last
    end

    def reject_index
      is_min_index = false
      if current_is_same?
        is_min_index = stocks.any? { |item| item.first == current.uniq.first }
      else
        is_min_index = current.first < current.last
      end
      is_min_index ? 0 : -1
    end

    def candidates
      tmp = targets.reject { |item| item[reject_index] == current.min || item == current }
      if tmp.one? && tmp.uniq.one?
        []
      else
        tmp
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
