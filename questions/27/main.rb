require 'benchmark'
require 'pry'

module Q27
  module_function

  WIDTH = 6
  # # WIDTH = 3
  HEIGHT = 4
  # # HEIGHT = 2

  def run
    start = 'r'
    fuga start, [[[0, 0], [1, 0]]]
    memo.length
    # # binding.pry
  end

  def memo
    @memo ||= []
  end

  def fuga(next_d, line)
    next_directions(next_d).each do |d|
      tmp = hoge d, line.last.last
      next unless can_use? tmp, line
      l = Array.new(line)
      l << tmp
      if is_goal? tmp.last
        @memo << l unless memo.include? l
      else
        fuga d, l
      end
    end
  end

  def hoge(next_d, position)
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
    position[0] <= WIDTH && position[-1] <= HEIGHT && position[0] >= 0 && position[-1] >= 0
  end

  def already_used?(next_line, line)
    line.include?(next_line) || line.include?(next_line.reverse)
  end

  def is_goal?(position)
    (position[0] == WIDTH) && (position[-1] == HEIGHT)
  end

  def direction
    @direction ||= %w(t l b r)
  end

  def next_directions(current)
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
