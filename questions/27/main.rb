require 'benchmark'
require 'pry'

module Q27
  module_function

  # # WIDTH, HEIGHT = 3, 2
  WIDTH = 6
  HEIGHT = 4

  def run
    start_direction = direction[-1]
    start_path = [[[0, 0], [1, 0]]]
    stock_paths start_direction, start_path
    memo.length
    # # binding.pry
  end

  def memo
    @memo ||= []
  end

  def stock_paths(current_direction, current_path)
    candidates(current_direction).each do |d|
      candidate_line = next_line d, current_path.last.last
      next unless can_use? candidate_line, current_path
      total_path = Array.new([*current_path, candidate_line])
      if goal? total_path.last.last
        @memo << total_path unless memo.include? total_path
      else
        stock_paths d, total_path
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
    (0..WIDTH).cover?(point[0]) && (0..HEIGHT).cover?(point[-1])
  end

  def not_used?(line, path)
    path.none? { |l| [line, line.reverse].include?(l) }
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
