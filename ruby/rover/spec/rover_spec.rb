require "rover"

RSpec.describe Rover, "#get_current_position" do
  context "given 1 2 N, LMLMLMLMM" do
    it "should face the correct direction" do
      rover = Rover.new
      expect(rover
        .set_grid("5 5")
        .set_starting_position("1 2 N")
        .parse_instructions("LMLMLMLMM")
        .get_current_position)
        .to contain_exactly(1, 1, "N")
    end
  end

  context "given 3 3 N, MMRMMRMRRM" do
    it "should face the correct direction" do
      rover = Rover.new
      expect(rover
        .set_grid("5 5")
        .set_starting_position("3 3 N")
        .parse_instructions("MMRMMRMRRM")
        .get_current_position)
        .to contain_exactly(5, 1, "N")
    end
  end
end

  
