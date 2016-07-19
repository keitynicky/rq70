require 'benchmark'

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
    # 対象となる文字列を保持
    expression = "READ+WRITE+TALK==SKILL"
    
    # 正規表現で文字列で分割しちゃう
    nums = expression.split(/[^a-zA-Z]/)
    
    # なんで空文字でsplitしてるんだろう？文字単位にしたいってことかな？？
    chars = nums.join().split("").uniq

    # 文字列で分割したやつの1桁目の配列を取得している
    head = nums.map{|num| num[0]}

    count = 0

    # 0から9の配列の順列を取得してる。
    (0..9).to_a.permutation(chars.size){|seq|
      # 0が最初であるかどうかのフラグを持っている？？
      is_zero_first = false

      # 順列の組み合わせで0を含んでいる場合
      if seq.include?(0) then
        # ここでやっていることがいまいちわからない。。
        is_zero_first = head.include?(chars[seq.index(0)])
      end

      if !is_zero_first then
        # trは並べた順番で置き換える。一番最初の文字のユニークな組み合わせで並べたもの
        e = expression.tr(chars.join(), seq.join())
        # ここでやっていることがいまいちわからない。。
        if eval(e) then
          puts e
          count += 1
        end      
      end
    }
    return count
  end

  def run_03
    count = 0
    (0..9).to_a.permutation(6){|e, a, d, t, k, l|
      if isTarget?(a + t) &&
         isTarget?(a + e) &&
         ((d + e + k) % 10 == l) &&
         (((a + t + l) * 10 + d + e + k) % 100 == l * 11) then
        ((0..9).to_a - [k, e, d, l, t, a]).permutation(4){|i, r, s, w|
          if ((r != 0) && (w != 0) && (t != 0)) &&
             ((s == w + 1) || (s == w + 2)) then
             read = getTextNum([r,e,a,d])
             write = getTextNum([w,r,i,t,e])
             talk = getTextNum([t,a,l,k])
             skill = getTextNum([s,k,i,l,l])
             if read + write + talk == skill then
               puts "#{read} + #{write} + #{talk} = #{skill}"
               count += 1
             end
          end
        }        
      end
    }
    return count    
  end

  def isTarget?(value)
    !!((value == 8) || (value == 9) || (value == 10))
  end 

  def getTextNum(arr)
    ret = 0
    length = arr.size - 1
    arr.each_with_index do |item, index|
      if index != length
        item *= (10 ** (length - index))
      end
      ret += item
    end
    ret
  end

end

Benchmark.bm do |x|
  x.report do
    $answer = Q13.run_03
  end
end

puts
puts "answer : #{$answer}"
