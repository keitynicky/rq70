require 'benchmark'
require "pry"

module Q20
  module_function

  def run
  end

end

Benchmark.bm do |x|
  x.report do
    $answer = Q20.run
  end
end

puts
puts "answer : #{$answer}"
