require 'benchmark'
require 'pry'

module Q25
  module_function

  HOLES = 6
  # HOLES = 3

  def run
    # binding.pry
    count = 0
    h = (1..HOLES - 1).to_a.permutation(HOLES - 1).to_a
    h.product(h) do |set|
      keep = set.transpose.flatten
      xx = [[0, keep.first]]
      keep.each_index do |i|
        tmp = [keep[i], (i + 1) == keep.size ? 0 : keep[i + 1]]
        tmp = tmp.reverse if i.even?
        xx << tmp
      end
      tmp = cross_count xx
      count = tmp if tmp > count
    end
    count
  end

  def cross_count(l)
    l.combination(2).count do |item|
      crossing? item.first, item.last
    end
  end

  def crossing?(line1, line2)
    line1_y1, line1_y2 = line1
    line2_y1, line2_y2 = line2
    x1 = 0
    x2 = 1
    ((x1 - x2) * (line2_y1 - line1_y1) + (line1_y1 - line1_y2) * (x1 - x1)) * ((x1 - x2) * (line2_y2 - line1_y1) + (line1_y1 - line1_y2) * (x1 - x2)) < 0 && 
    ((x1 - x2) * (line1_y1 - line2_y1) + (line2_y1 - line2_y2) * (x1 - x1)) * ((x1 - x2) * (line1_y2 - line2_y1) + (line2_y1 - line2_y2) * (x1 - x2)) < 0
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
