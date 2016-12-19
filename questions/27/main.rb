require 'benchmark'
require 'pry'

module Q27
  module_function

  WIDTH, HEIGHT = 3, 2
  # # WIDTH, HEIGHT = 6, 4

  def run
    start = 'r'
    stock_routes start, [[[0, 0], [1, 0]]]
    memo.length
    # # binding.pry
  end

  def memo
    @memo ||= []
  end

  def stock_routes(next_d, path)
    candidates(next_d).each do |d|
      tmp = lineosition d, path.last.last
      next unless can_use? tmp, path
      l = Array.new(path)
      l << tmp
      if goal? tmp.last
        @memo << l unless memo.include? l
      else
        stock_routes d, l
      end
    end
  end

  def lineosition(next_d, point)
    tmp = []
    tmp.push point
    x = Array.new(point)
    if %(t b).include? next_d
      x[-1] += next_d == 't' ? 1 : -1
    else
      x[0] += next_d == 'r' ? 1 : -1
    end
    tmp.push x
    tmp
  end

  def can_use?(line, path)
    in_range?(line.last) && not_used?(line, path) && !start_or_end?(line.last, path)
  end

  def in_range?(point)
    point.zip([WIDTH, HEIGHT]).all? { |a, b| a <= b } && point.all? { |a| a >= 0 }
  end

  def not_used?(line, path)
    !path.any? { |l| [line, line.reverse].include?(l) }
  end

  def start_or_end?(point, path)
    point == [0, 0] || goal?(path.last.last)
  end

  def goal?(point)
    point == [WIDTH, HEIGHT]
  end

  def direction
    @direction ||= %w(t l b r)
  end

  def candidates(current)
    [current, direction.rotate!(direction.index(current))[1]]
  end
end

Benchmark.bm do |x|
  x.report do
    $answer = Q27.run
    $correct = 2760
  end
end

puts
puts "answer : #{$answer}"
puts "correct : #{$correct}"
