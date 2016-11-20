require "spec_helper"
require_relative '../main'

describe "Q25" do
  let(:extended_class) { Class.new { extend Q25 } }
  
  describe "answer" do
    # it "例題の個数" do
    #     x = extended_class.answer extended_class.candidates 6
    #     expect(x.first).to eq 45
    # end

    it "例題の個数の半分" do
        x = extended_class.answer extended_class.candidates 3
        expect(x.first).to eq 6
    end
  end

  describe "shoelace" do
    it "パターン１" do
        x = extended_class.shoelace [1, 2, 2, 1]
        expect(x).to eq [[0, 1], [2, 1], [2, 2], [1, 2], [1, 0]]
    end

    it "パターン2" do
        x = extended_class.shoelace [2, 2, 1, 1]
        expect(x).to eq [[0, 2], [2, 2], [2, 1], [1, 1], [1, 0]]
    end
  end

  describe "crossing" do
    it "パターン1" do
        x = extended_class.crossing? [1, 2], [2, 1]
        expect(x).to be_truthy
    end

    it "パターン2" do
        x = extended_class.crossing? [1, 2], [2, 2]
        expect(x).to be_falsey
    end

    it "パターン3" do
        x = extended_class.crossing? [1, 2], [0, 3]
        expect(x).to be_truthy
    end

    it "パターン4" do
        x = extended_class.crossing? [1, 1], [0, 3]
        expect(x).to be_truthy
    end

    it "パターン5" do
        x = extended_class.crossing? [0, 3], [1, 3]
        expect(x).to be_falsey
    end
  end

end
