require 'benchmark'

module Q00
  module_function
  BOY_COUNT = 20
  GIRL_COUNT = 10

=begin
  module_function

  def count states
    if done? states.last
      1
    else if valid? states.last
      count(states + [[states.last[0] + 1, states.last[1]]]) +
          count(states + [[states.last[0], states.last[1] + 1]])
    else
      0
    end
  end
  def valid? state
    (state == [0, 0]) ||
    (
      (state[0] <= BOY_COUNT) && (state[1] <= GIRL_COUNT) &&
      (state[0] != state[1]) && (BOY_COUNT - state[0] != GIRL_COUNT - state[1])
    )
  end

  def done? state
    state[0] == [BOY_COUNT, GIRL_COUNT]
  end

  def run
    count([[0, 0]])
  end
=end

  def ___run
    boy, girl = BOY_COUNT + 1, GIRL_COUNT + 1
    # 配列を男性女性の2次元表で取得。そのすべてを0で初期化
    ary = Array.new(boy * girl){0}
    ary[0] = 1
    girl.times{|g|
      boy.times{|b|
        #男女が同数になる場所以外をカウント対象とする
        if (b != g) && (boy - b != girl - g) then
          index = b + boy * g
          ary[index] += ary[(b - 1) + boy * g] if b > 0
          ary[index] += ary[b + boy * (g - 1)] if g > 0
        end
      }
    }
    # 全体の最後から2番目の要素と男性の数ぶん前の要素（なぜ？！）
    ary[-2] + ary[-boy - 1]
  end

  def _run
    boy, girl = 20, 10
    boy, girl = boy + 1, girl + 1
    ary = Array.new(boy * girl){0}
    ary[0] = 1
    girl.times{|g|
      boy.times{|b|
        if (b != g) && (boy - b != girl - g) then
          ary[b + boy * g] += ary[b - 1 + boy * g] if b > 0
          ary[b + boy * g] += ary[b + boy * (g - 1)] if g > 0
        end
      }
    }
    ary[-2] + ary[-boy - 1]
  end
end

Benchmark.bm do |x|
  x.report do
    $answer = Q00.run
  end
end

puts
puts "answer : #{$answer}"
