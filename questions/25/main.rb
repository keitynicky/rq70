require 'benchmark'
require 'pry'

module Q25
  # module_function

  # HOLES = 6
  HOLES = 3

  def run
    # binding.pry
    answer candidates HOLES
  end

  def candidates(holes)
    (1..holes - 1).to_a.permutation(holes - 1).to_a
  end

  def answer(candidates)
    ans = [0, []]
    candidates.product(candidates) do |set|
      c = cross_count shoelace set.transpose.flatten
      ans = c if c.first > ans.first
    end
    ans
  end

  def shoelace(candidates)
    [[0, candidates.first]] + candidates.each_with_index.map do |_n, i|
      tmp = [candidates[i], (i + 1) == candidates.size ? 0 : candidates[i + 1]]
      i.even? ? tmp.reverse : tmp
    end
  end

  def cross_count(l)
    [l.combination(2).count do |item|
      crossing? item.first, item.last
    end, l]
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

# Benchmark.bm do |x|
#   x.report do
#     $answer = Q25.run
#     $correct = 45
#   end
# end

# puts
# puts "answer : #{$answer}"
# puts "correct : #{$correct}"
