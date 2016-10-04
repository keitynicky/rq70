require 'benchmark'
require "pry"

module Q19
  module_function

  def run
  end

end

Benchmark.bm do |x|
  x.report do
    $answer = Q19.run
  end
end

puts
puts "answer : #{$answer}"
