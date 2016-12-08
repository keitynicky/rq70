require 'benchmark'
require 'pry'

module Q26
  module_function

  WIDTH = 3
  HEIGHT = 2
  GOAL = WIDTH * HEIGHT
  TARGET_CAR = 1
  OTHER_CAR = 0
  EMPTY_SPACE = nil

  def run
    binding.pry

  end

  def parking_area
    a = Array.new(HEIGHT) {Array.new(WIDTH,OTHER_CAR)}
    a[0][0] = TARGET_CAR
    a[HEIGHT - 1][WIDTH - 1] = EMPTY_SPACE
    a
  end

  #要リファクタ
  def target_car_min_route
    ret = []
    (1..GOAL).step(WIDTH + 1).each do |i|
      ret << [ret, i].flatten.uniq
      ret << [ret.last ,i + 1].flatten
    end
    ret
  end

  def move_list
    @move_list = [[0, 1], [0, -1], [1, 0], [-1, 0]]
  end

  def next_candidates(x, y)
    move_list.map do |item|
      unless x + item.first < 0 || x + item.first > WIDTH || y + item.last < 0 || y + item.last > HEIGHT
        [x + item.first, y + item.last]
      end
    end.compact
  end

end


=begin
123
456

6-63-632-6321☆-63214-632145-6321452☆-63214523-632145236-6321452365☆

1-12-125-1256

●の移動経路を保持
空白を動かす
  空白が●の移動経路に等しいか
    GOALか

下右 
右下

下　start + 横
右　start + 1


うーん、どういう切り口でいけばいいのかな？
幅優先探索がいまいちわかっていないんだよね。。

6-5-4-1
6-5-2-3
6-5-2-4
6-5-2-1
6-3-2

うーん、どうしよう？？

=end

Benchmark.bm do |x|
  x.report do

    $answer = Q26.run
    $correct = 69
  end
end

puts
puts "answer : #{$answer}"
puts "correct : #{$correct}"
