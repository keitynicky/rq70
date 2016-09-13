require 'benchmark'

module Q16
  module_function

  def run
  end
end

Benchmark.bm do |x|
  x.report do
    $answer = Q16.run
  end
end

puts
puts "answer : #{$answer}"
