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
    lines_combination.each do |lines|
      cross_count lines
    end
    counts.max
  end

  def lines_combination
    lines = []
    lines.push [[0, 1], [1, 0], [1, 2], [2, 1]]
    lines.push [[1, 0], [1, 1], [2, 1], [2, 2], [0, 2]]
  end

  def cross_count(l)
    counts.push((l.size - l.count { |line| line.first < line.last }).abs)
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
