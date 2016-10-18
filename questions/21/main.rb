require 'benchmark'
require "pry"

module Q21
  module_function

  def run
  end

end

Benchmark.bm do |x|
  x.report do
    $answer = Q21.run
  end
end

puts
puts "answer : #{$answer}"
