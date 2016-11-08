require 'benchmark'
require "pry"

module Q23
  module_function

  def run
  end

end

Benchmark.bm do |x|
  x.report do
    $answer = Q23.run
  end
end

puts
puts "answer : #{$answer}"