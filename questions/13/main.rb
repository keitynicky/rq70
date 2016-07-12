require 'benchmark'
require 'pry'

module Q13
  module_function

  def run
    count = 0
    # permutationt→要チェック
    # ↑配列の組み合わせを取得する。引数ゼロだから、組み合わせ1つを取得
    (0..9).to_a.permutation do |r, e, a, d, w, i, t, l, k, s|
      next if r == 0 or w == 0 or t == 0 or s == 0
      read = r * 1000 + e * 100 + a * 10 + d
      write = w * 10000 + a * 100 + l * 10 + e
      talk = t * 1000 + a * 100 + l * 10 + k
      skill = s * 10000 + k * 1000 + i * 100 + l * 10 + l
      if read + write + talk == skill then
        count += 1
        puts "#{read} + #{write} + #{talk} + #{skill}"
      end
    end
    return count
  end

  def run_reg
    expression = "READ+WRITE+TALK==SKILL"
    nums = expression.split(/[^a-zA-Z]/)
    chars = nums.join().split("").uniq
    head = nums.map{|num| num[0]}

    count = 0
    (0..9).to_a.permutation(char.size){|seq|
      is_zero_first = false
      if seq.include?(0) then
        is_zero_first = head.include?(chars[seq.index(0)])
      end
      if !is_zero_first then
        # trって？？
        # 並べた順番で置き換える。一番最初の文字のユニークな組み合わせで並べたもの
        e = expression.tr(chars.join(), seq.join())
        if eval(e) then
          puts e
          count += 1
        end      
      end
    }
    return count
  end
end

Benchmark.bm do |x|
  x.report do
    $answer = Q12.run
  end
end

puts
puts "answer : #{$answer}"
