require 'benchmark'
require 'pry'

module Q25
  module_function

  HOLES = 6
  # HOLES = 3

  def counts
    @counts ||= []
  end

  def run
    # binding.pry
    test
  end

  def test
    count = 0
    h = (1..HOLES - 1).to_a.permutation(HOLES - 1).to_a
    h.product(h) do |set|
      keep = set.transpose.flatten
      xx = [[0, keep.first]]
      keep.each_index do |i|
        tmp = [keep[i], (i + 1) == keep.size ? 0 : keep[i + 1]]
        if i.even?
          tmp = tmp.reverse
        end
        xx << tmp
      end
      tmp = cross_count xx
      if tmp > count
        count = tmp
      end
    end
    count
  end

  def cross_count(l)
    count = 0
    l.combination(2) do |item|
      count += 1 if crossing? item.first, item.last
    end
    count
  end

  def crossing?(line1, line2)
    line1_ay, line1_by = line1
    line2_ay, line2_by = line2
    line1_ax = line2_ax = 0
    line1_bx = line2_bx = 1
    if ((line1_ax - line1_bx) * (line2_ay - line1_ay) + (line1_ay - line1_by) * (line1_ax - line2_ax)) * ((line1_ax - line1_bx) * (line2_by - line1_ay) + (line1_ay - line1_by) * (line1_ax - line2_bx)) < 0
      if ((line2_ax - line2_bx) * (line1_ay - line2_ay) + (line2_ay - line2_by) * (line2_ax - line1_ax)) * ((line2_ax - line2_bx) * (line1_by - line2_ay) + (line2_ay - line2_by) * (line2_ax - line1_bx)) < 0
        true
      end
    else
      false
    end
  end

end

class Line < Struct.new :input

  def x1
    0    
  end

  def y1
    input.first
  end

  def x2
    1    
  end

  def y2
    input.last
  end

  def crossing? line
    if ((self.x1 - self.x2) * (line.y1 - self.y1) + (self.y1 - self.y2) * (self.x1 - line.x1)) * ((self.x1 - self.x2) * (line.y2 - self.y1) + (self.y1 - self.y2) * (self.x1 - line.x2)) < 0
      if ((line.x1 - line.x2) * (self.y1 - line.y1) + (line.y1 - line.y2) * (line.x1 - self.x1)) * ((line.x1 - line.x2) * (self.y2 - line.y1) + (line.y1 - line.y2) * (line.x1 - self.x2)) < 0
        true
      end
    else
      false
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
