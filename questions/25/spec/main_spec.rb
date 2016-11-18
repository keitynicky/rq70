require "spec_helper"
require_relative '../main'

describe "Q25" do
  let(:extended_class) { Class.new { extend Q25 } }
  
  it "start_target" do
    x = extended_class.start_target 1    
    expect(x).to eq [[0, 1], [1, 0], [1, 1]]
  end

  describe "cross_count" do
      it "複数②" do
        tmp = extended_class.start_target 5
        x = extended_class.cross_count [*tmp, [0,0]]
        expect(x).to eq [45]
      end
  end

  describe "Counter" do
    it "min_index" do
        x = Counter.new [0,1]
        expect(x.min_index).to eq 0
    end

    it "max_index" do
        x = Counter.new [0,1]
        expect(x.max_index).to eq -1
    end

    it "except" do
        x = Counter.new [1,1]
        expect(x.except?).to be_truthy
    end

    it "crossing" do
        x = Counter.new [0,1]
        expect(x.crossing? [1, 0]).to be_truthy
        expect(x.crossing? [2, 0]).to be_truthy
        expect(x.crossing? [1, 1]).to be_falsey
    end

    it "crossing" do
        x = Counter.new [0,2]
        expect(x.crossing? [1, 1]).to be_truthy
    end

    it "cross_pair" do
        x = Counter.new [0,1]
        x.crossing? [1, 0]
        expect(x.cross_pair).to eq [[0,1], [1,0]]
        x.crossing? [2, 0]
        expect(x.cross_pair).to eq [[0,1], [2,0]]                
    end
  end

end