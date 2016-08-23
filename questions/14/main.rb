require 'benchmark'

module Q14
  module_function

  @country = [
    "Australia",
    "Cote dlvoire",
    "Iran",
    "Japan",
    "Korea Republic",
    "Algeria",
    "Cameroon",
    "Ghana",
    "Nigeria",
    "Costa Rica",
    "Honduras",
    "Mexico",
    "United States",
    "Argentina",
    "Brazil",
    "Chile",
    "Colombia",
    "Ecuador",
    "Uruguay",
    "Belgium",
    "Bosnia and Herzegovina",
    "Croatia",
    "England",
    "France",
    "Germany",
    "Greece",
    "Italy",
    "Netherlands",
    "Portugal",
    "Russia",
    "Spain",
    "Switzerland",
    "USA"]
  
  @is_used = Array.new(@country.size, false)

  def run
    @max_depth = 0
    @country.each_with_index{|c, i|
      @is_used[i] = true
      search(c, 1)
      @is_used[i] = false 
    }

    @max_depth
  end

  def search(prev, depth)
    is_last = true
    @country.each_with_index{|c, i|
      # しりとりチェック
      if c[0] == prev[-1].upcase then
        if !@is_used[i] then
          is_last = false
          @is_used[i] = true
          search(c, depth + 1)
          @is_used[i] = false  
        end
      end
    }   
    @max_depth = [@max_depth, depth].max if is_last 
  end

end

Benchmark.bm do |x|
  x.report do
    $answer = Q14.run
  end
end

puts
puts "answer : #{$answer}"
