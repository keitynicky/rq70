require 'benchmark'
require 'pry'

module Q25
  module_function

  # HOLES = 6
  HOLES = 3

  def counts
    @counts ||= []
  end

  def run
    test
  end

  def test
    count = 0
    h = (1..HOLES - 1).to_a.permutation(HOLES - 1).to_a
    h.product(h) do |set|
      keep = set.transpose.flatten
      xx = [[0, keep.first]]
      keep.each_index do |i|
        xx << [keep[i], (i + 1) == keep.size ? 0 : keep[i + 1]]
      end
      tmp = cross_count xx
      if tmp > count
        count = tmp
      end
    end
    count
  end

  def cross_count(l)
    tmp = {}
    l.each do |i|
      hoge = (l - [i]).select do |x|
        if x.uniq.size == 1
          x.min > i.min && x.max < i.max
        else
          x.min >= i.min && x.max <= i.max
        end
      end
      if hoge.any?
        key = [i, *hoge].sort
        tmp[key] ||= hoge.count
      end
    end
    tmp.values.inject(:+)
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
