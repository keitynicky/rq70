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
      xor_rows.push(get_row_with_padding_zero(xor_rows.last))
      count += get_count_of_zero(xor_rows.last)
    end
    row_index
  end

  def get_row_with_padding_zero before_row
    [0, set_row_xor_values(before_row), 0].flatten
  end

  def set_row_xor_values before_row
    xor_values = []
    if before_row.nil?
      xor_values.push(1)
    else
      before_row.each_cons(XOR_INPUT).each{|xor_pair|
        xor_values.push(xor_pair.first ^ xor_pair.last)
      }
    end
    xor_values
  end

  def get_count_of_zero row
    trim_row = row[1..-2]
    trim_row.count{|item| item == 0}
  end

end

Benchmark.bm do |x|
  x.report do
    $answer = Q21.run
  end
end

puts
puts "answer : #{$answer}"
