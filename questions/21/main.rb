require 'benchmark'
require "pry"

module Q21
  module_function

  LAST_COUNT = 2014
  XOR_INPUT = 2

  def run
    row_index = 0
    count = 0
    xor_rows = []
    while count < LAST_COUNT
      row_index += 1
      xor_rows.push get_row(xor_rows.last)
      count += xor_rows.last[1..-2].count{|item| item == 0}
    end
    row_index
  end

  def get_row before_row
    row = []
    row.push 0
    if before_row.nil?
      row.push 1
    else
      before_row.each_cons(XOR_INPUT).each{|xor_pair|
        row.push xor_pair.first ^ xor_pair.last
      }
    end
    row.push 0
    row      
  end

end

Benchmark.bm do |x|
  x.report do
    $answer = Q21.run
  end
end

puts
puts "answer : #{$answer}"
