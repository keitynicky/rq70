require 'benchmark'
require 'pry'

module Q27
  module_function

  # WIDTH = 6
  WIDTH = 1
  # HEIGHT = 4
  HEIGHT = 1

  def run
    start = 'r'
    # hoge start
    binding.pry
  end

  def hoge(current)
    nexts = next_directions current
  end

  def set_next_position(next_d)
    if %(t b).include? next_d
      position[-1] += next_d == 't' ? 1 : -1
    else
      position[0] += next_d == 'r' ? 1 : -1
    end
  end

  def mark(next_d)
    set_next_position(next_d)
    if enable_use? position
      if %(t b).include? next_d
        h_list[position[0]][position[-1]] = 1
      else
        w_list[position[0]][position[-1]] = 1
      end
    else

    end
  end

  def enable_use?(position)
    position[0] <= WIDTH && position[-1] <= HEIGHT && position[0] >= 0 && position[-1] >= 0
  end

  def position
    @position ||= [0, HEIGHT - 1]
  end

  def direction
    @direction ||= %w(t l b r)
  end

  def next_directions(current)
    [current, direction.rotate!(direction.index(current))[1]]
  end

  def w_list
    @w_list ||= list HEIGHT + 1, WIDTH
  end

  def h_list
    @h_list ||= list HEIGHT, WIDTH + 1
  end

  def list(p1, p2)
    Array.new(p1) { |i| Array.new(p2, 0)}
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