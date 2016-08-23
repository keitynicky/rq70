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
  @max_depth = 0

  def run
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

  def run2
    @country.each{|c|
      search2(@country - [c], c, 1)
    }
    @max_depth
  end

  def search2(countries, prev, depth)
    next_country = countries.select{|c| c[0] == prev[-1].upcase}
    if next_country.size > 0 then
      next_country.each{|c|
        search2(countries - [c], c, depth + 1)
      }
    else
      @max_depth = [@max_depth, depth].max
    end
  end
end

Benchmark.bm do |x|
  x.report do
    $answer = Q14.run
  end
end

puts
puts "answer : #{$answer}"
