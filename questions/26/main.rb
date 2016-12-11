require 'benchmark'
require 'pry'

module Q26
  module_function

  WIDTH = 10
  HEIGHT = 10

  def run
    # 空白スペースを左上までもっていくステップ数 
    step_going = WIDTH + HEIGHT - 2
    # 左上の車を右下まで持っていくステップ数
    step_return =(WIDTH - 1 + HEIGHT - 2) * 3
    # 問題には幅優先探索を用いてとありましたが、最短ルートを求めるので上の法則でもいいのかなと思いました。
    step_going + step_return
  end

end

Benchmark.bm do |x|
  x.report do

    $answer = Q26.run
    $correct = 69
  end
end

puts
puts "answer : #{$answer}"
puts "correct : #{$correct}"
