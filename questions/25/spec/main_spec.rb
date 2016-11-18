require "spec_helper"
require_relative '../main'

describe "Q25" do
  let(:extended_class) { Class.new { extend Q25 } }
  
  it "start_target" do
    x = extended_class.start_target 1    
    expect(x).to eq [[0, 1], [1, 0], [1, 1]]
  end

  describe "cross_count" do
      it "基本" do
        x = extended_class.cross_count [[0, 1], [1, 0]]
        expect(x).to eq [1]
      end

      it "複数" do
        x = extended_class.cross_count [[0, 1], [1, 0], [1, 2], [2, 1]]
        expect(x).to eq [2]
      end

      it "複数②" do
        x = extended_class.cross_count [[0, 1], [1, 1], [1, 2], [2, 2], [2, 0]]
        expect(x).to eq [3]
      end

      it "複数②" do
        tmp = extended_class.start_target 2
        x = extended_class.cross_count [*tmp, [0,0]]
        expect(x).to eq [6]
      end

      it "複数②" do
        tmp = extended_class.start_target 5
        x = extended_class.cross_count [*tmp, [0,0]]
        p x
        expect(x).to eq [45]
      end
  end

  describe "tie_shoes" do
    # it "穴が3つ" do
    #     tmp = extended_class.start_target 2
    #     x = Stocker.new tmp, [tmp.first]        
    #     extended_class.tie_shoes tmp, [tmp.first]
    #     expect(extended_class.counts).to eq [6]
    # end

    # it "穴が6つ" do
    #     tmp = extended_class.start_target 5
    #     x = Stocker.new tmp, [tmp.first]        
    #     extended_class.tie_shoes tmp, [tmp.first]
    #     expect(extended_class.counts).to eq [45]
    # end
  end

  describe "Stocker" do
    it "current" do
        tmp = extended_class.start_target 1
        x = Stocker.new tmp, [tmp.first]
        expect(x.current).to eq tmp.first
    end

    it "completed" do
        tmp = extended_class.start_target 1
        x = Stocker.new tmp.last, tmp[0..-2]
        expect(x.completed?).to be_truthy
    end

    it "current_is_same" do
        x = Stocker.new [[]], [[1,1]]
        expect(x.current_is_same?).to be_truthy
    end

    describe "reject_index" do
        it "同じ値でなく、first" do
            tmp = extended_class.start_target 1
            x = Stocker.new tmp, [tmp.first]
            expect(x.reject_index).to eq 0
        end

        it "同じ値でなく、last" do
            tmp = extended_class.start_target 1
            x = Stocker.new tmp[2], tmp[0..1]
            expect(x.reject_index).to eq -1
        end

        it "同じ値で、first" do
            x = Stocker.new [[2,2]], [[0,1],[1,0],[1,2]]
            expect(x.reject_index).to eq 0
        end

        it "同じ値で、last" do
            x = Stocker.new [[2,2]], [[0,1],[1,0],[2,1]]
            expect(x.reject_index).to eq -1
        end
    end

    describe "candidates" do
        it "穴の数が2つで初回" do
            tmp = extended_class.start_target 1
            x = Stocker.new tmp, [tmp.first]
            expect(x.candidates).to eq [[1,0],[1,1]]
        end

        it "穴の数が3つで初回" do
            tmp = extended_class.start_target 2
            x = Stocker.new tmp, [tmp.first]
            expect(x.candidates).to eq [[1,0],[1,1],[1,2],[2,0],[2,1],[2,2]]
        end

        it "穴の数が3つで初回" do
            tmp = extended_class.start_target 2
            x = Stocker.new tmp, [tmp.first]
            expect(x.candidates).to eq [[1,0],[1,1],[1,2],[2,0],[2,1],[2,2]]
        end
    end

    describe "except" do
        it "穴の数が3つで初回" do
            tmp = extended_class.start_target 2
            x = Stocker.new tmp, [tmp.first]
            expect(x.except).to eq [[0,1],[0,2]]
        end
    end

    describe "except_next" do
        it "穴の数が3つで初回" do
            tmp = extended_class.start_target 2
            x = Stocker.new tmp, [tmp.first]
            expect(x.except_next).to eq [[0,2]]
        end
    end
  end

end