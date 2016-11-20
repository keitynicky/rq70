require "spec_helper"
require_relative '../main'

describe "Q25" do
  let(:extended_class) { Class.new { extend Q25 } }
  
  it "shoelace" do
    x = extended_class.shoelace [1, 2, 2, 1]
    expect(x).to eq [[0, 1], [2, 1], [2, 2], [1, 2], [1, 0]]
  end

end
