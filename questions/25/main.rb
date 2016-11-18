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
    moga
  end

  def moga
    targets = (0..HOLES).to_a.repeated_permutation(2).drop(1)
    stocks = targets.first
    fuga targets.drop(1), [stocks]
    counts.max
  end

  def fuga(targets, stocks)
    y = X.new targets, stocks
    if y.completed?
      cross_count y.stocks
    else
      current = y.candidates.first
      fuga(y.candidates.drop(1), y.stocks.push(current))
    end
  end

  def cross_count(l)
    counts.push((l.size - l.count { |line| line.first < line.last }).abs)
  end

  def get_lines(lines)
  end

  class X < Struct.new :targets, :stocks
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
