require "spec_helper"
require_relative '../main'

describe "Q25" do
  let(:extended_class) { Class.new { extend Q25 } }
  
  it "start_target" do
    x = extended_class.start_target 1    
    expect(x).to eq [[0, 1], [1, 0], [1, 1]]
  end
end
