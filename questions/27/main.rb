require 'benchmark'
require 'pry'

module Q27
  module_function

  # WIDTH = 6
  WIDTH = 2
  # HEIGHT = 4
  HEIGHT = 2

  def run
    start = 'r'
    # hoge start
    binding.pry
  end

  # def line
  #   @line ||= []
  # end

  def memo
    @memo ||= []
  end

  def fuga(next_d, line, position)
    tmp = hoge next_d, position
    if can_use? tmp, line
      position = Array.new(tmp.last)
      line << tmp
      if is_goal? tmp.last
        unless memo.include? line
          @memo << line
          fuga "r", [], [0,0]
        end
      else
        next_directions(next_d).each do |d|
          fuga d, line, position
        end
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

  def count
    @count ||= 0
  end

  def can_use? next_line, line
    in_range?(next_line.last) && !line.include?(next_line)
  end 

  def in_range?(position)
    position[0] <= WIDTH && position[-1] <= HEIGHT && position[0] >= 0 && position[-1] >= 0
  end

  def is_goal?(position)
    (position[0] == WIDTH) && (position[-1] == HEIGHT)
  end

  # def position
  #   @position ||= [0, 0]
  # end

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
