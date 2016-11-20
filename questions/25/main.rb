require 'benchmark'
require 'pry'

module Q25
  module_function

  HOLES = 6
  # HOLES = 3
  LEFT_X = 0
  RIGHT_X = 1
  EACH_LINE = 2

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
      targets = shoelace set.transpose.flatten
      c = cross_count targets
      ans = [c, targets] if c > ans.first
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
    l.combination(EACH_LINE).count do |item|
      crossing? item.first, item.last
    end
  end

  def crossing?(line1, line2)
    l1_y1, l1_y2 = line1
    l2_y1, l2_y2 = line2
    (l1_y1 - l2_y1) * (l1_y2 - l2_y2) < 0
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
