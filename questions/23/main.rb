require 'benchmark'
require 'pry'

module Q23
  module_function

  COIN_COUNT = 10
  GAME_COUNT = 24

  @memo = {}

  def run
    game(COIN_COUNT, GAME_COUNT)
  end

  def game(coin, depth)
    return @memo[[coin, depth]] if @memo.has_key?([coin, depth])
    return 0 if coin == 0
    return 1 if depth == 0
    win = game(coin + 1, depth - 1)
    lose = game(coin - 1, depth - 1)
    @memo[[coin, depth]] = win + lose
  end

  # 自力断念！
  # 再帰を使って、指定されたゲーム回数でどういったパターンがあるのかを取得して、その中から条件を満たすものを抽出しようとしたけれど、、無理でした！
  # @list = []
  # def run
  #   list = [
  #     [1, 2, 3, 4, 5],
  #     [1, 2, 3, 4, 3],
  #     [1, 2, 3, 2, 3],
  #     [1, 2, 3, 2, 1],
  #     [1, 2, 1, 2, 3],
  #     [1, 2, 1, 2, 1],
  #     [1, 2, 1, 0],
  #     [1, 0]
  #   ]

  #   over_game_count list
  #   binding.pry
  # end

  # def over_game_count list
  #   list.select {|items| items.count >= GAME_COUNT}
  # end

  # def branch_items items
  #   [-1, 1].each{ |i|
  #     if items.last.zero? || @list.count == GAME_COUNT
  #       @list.push items
  #     else
  #       items.push items.last + i
  #       branch_items items
  #     end
  #   }
  #   items
  # end

end

Benchmark.bm do |x|
  x.report do
    $answer = Q23.run
  end
end

puts
puts "answer : #{$answer}"
