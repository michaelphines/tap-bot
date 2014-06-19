$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require 'rspec'
require 'tap_bot'

describe TapBot do
  describe ".fit_ratio" do
    it "returns the width ratio if smaller" do
      ratio = TapBot.fit_ratio([2,4], [1,4])
      expect(ratio).to eq(0.5)
    end

    it "returns the height ratio if smaller" do
      ratio = TapBot.fit_ratio([4,2], [4,1])
      expect(ratio).to eq(0.5)
    end

    it "returns 1 if the width and height ratios larger than 1" do
      ratio = TapBot.fit_ratio([1,2], [3,4])
      expect(ratio).to eq(1)
    end
  end
end
