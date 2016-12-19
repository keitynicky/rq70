require 'benchmark'
require 'pry'

module Q27
  module_function

  # # WIDTH = 6
  WIDTH = 3
  # # HEIGHT = 4
  HEIGHT = 2

  def run
    start = 'r'
    stock_routes start, [[[0, 0], [1, 0]]]
    memo.length
    # # binding.pry
  end

  def memo
    @memo ||= []
  end

  def stock_routes(next_d, line)
    candidates(next_d).each do |d|
      tmp = next_position d, line.last.last
      next unless can_use? tmp, line
      l = Array.new(line)
      l << tmp
      if goal? tmp.last
        @memo << l unless memo.include? l
      else
        stock_routes d, l
      end
    end
  end

  def next_position(next_d, position)
    tmp = []
    tmp.push position
    x = Array.new(position)
    if %(t b).include? next_d
      x[-1] += next_d == 't' ? 1 : -1
    else
      x[0] += next_d == 'r' ? 1 : -1
    end
    tmp.push x
    tmp
  end

  def can_use?(next_line, line)
    in_range?(next_line.last) && !already_used?(next_line, line) && next_line.last != [0, 0] && line.last.last != [WIDTH, HEIGHT]
  end

  def in_range?(position)
    position.zip([WIDTH, HEIGHT]).all? { |a, b| a <= b } && position.all? { |a| a >= 0 }
  end

  def already_used?(next_line, line)
    line.include?(next_line) || line.include?(next_line.reverse)
  end

  def goal?(position)
    (position[0] == WIDTH) && (position[-1] == HEIGHT)
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
