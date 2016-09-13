require 'benchmark'
require "pry"

module Q16
  module_function

  LINE_MAX = 500

  # 写経！
  def run
    answer = []
    (1..LINE_MAX/4).each{|c|
      edge = (1..(c-1)).to_a.map{|tate| tate * (2 * c - tate)}
      edge.combination(2){|a,b|
        if a + b == c * c
          answer.push([1, b/a.to_f, c*c/a.to_f])          
        end
      }
    }
    answer.uniq!
    answer.size
  end

  # 自分で試行錯誤！えーんやこら！だがしかし！実らず！！！
  @square_areas = []
  @rect1_areas = []
  @rect2_areas = []

  def run_backup
    count = 0
    set_square_areas
    @rect1_areas = get_rect_areas
    @rect2_areas = get_rect_areas
    @square_areas.each{|square|
      @rect1_areas.each{|rect1|
        @rect2_areas.each{|rect2|
          if square = rect1.area + rect2.area
            binding.pry
            count += 1
          end
        }
      }
    }

    binding.pry
    count
  end

  def set_square_areas
    (1..LINE_MAX).each{|square_len|
      square_line = (square_len / 4)
      if square_line.integer?
        @square_areas.push(square_line ** 2)
      end
    }
  end  
  
  def get_rect_areas
    rectangle_area = []
    (1..LINE_MAX).each{|len1|
      half = (len1 / 2) 
      if half.integer?
        (1..half).each{|len2|
          tmp = Rect.new(half - len2 ,len2)
          if tmp.correct?
            rectangle_area.push(tmp)
          end
        }
      end
    }
    rectangle_area
  end

  class Rect < Struct.new :width, :hight
    def area
      width * hight
    end

    def correct?
      width > 0 && hight > 0 && width - hight != 0
    end

    def inspect
      "(#{width}, #{hight})"
    end
  end
end

Benchmark.bm do |x|
  x.report do
    $answer = Q16.run
  end
end

puts
puts "answer : #{$answer}"
