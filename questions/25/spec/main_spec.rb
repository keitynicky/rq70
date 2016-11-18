require "spec_helper"
require_relative '../main'

describe "Q25" do
  let(:extended_class) { Class.new { extend Q25 } }
  
  it "start_target" do
    x = extended_class.start_target 1
    expect(x).to eq [[0, 1], [1, 0], [1, 1]]
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
  end

end