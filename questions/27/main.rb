require 'benchmark'
require 'pry'

module Q27
  module_function

  WIDTH, HEIGHT = 3, 2
  # # WIDTH, HEIGHT = 6, 4

  def run
    start_direction = direction[-1]
    start_path = [[[0, 0], [1, 0]]]
    stock_routes start_direction, start_path
    memo.length
    # # binding.pry
  end

  def memo
    @memo ||= []
  end

  def stock_routes(current_direction, path)
    candidates(current_direction).each do |d|
      line = next_line d, path.last.last
      next unless can_use? line, path
      l = Array.new(path)
      l << line
      if goal? line.last
        @memo << l unless memo.include? l
      else
        stock_routes d, l
      end
    end
  end

  def next_line(current_direction, point)
    [point, next_point(current_direction, point)]
  end

  def next_point(direction, point)
    x, y = point
    if top_or_bottom? direction
      [x,  y + move(direction, 't')]
    else
      [x + move(direction, 'r'), y]
    end
  end

  def move(direction, increase)
    direction == increase ? 1 : -1
  end

  def top_or_bottom?(current_direction)
    %w(t b).include? current_direction
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
