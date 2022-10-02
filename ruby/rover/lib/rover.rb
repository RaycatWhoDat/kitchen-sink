DIRECTIONS = %i[N E S W]
DELTAS = {
  :N => [0, -1],
  :E => [1, 0],
  :S => [0, 1],
  :W => [-1, 0],
}

class Rover
  attr_accessor :grid_height, :grid_width, :x, :y, :direction

  def initialize
    @grid_height = 0
    @grid_width = 0
    @x = 0
    @y = 0
    self
  end

  def get_current_position
    [@x, @y, @direction.to_s]
  end

  def set_grid(grid_config)
    width, height = grid_config.split(" ")
    @grid_height = height.to_i
    @grid_width = width.to_i
    self
  end

  def set_starting_position(starting_position)
    starting_x, starting_y, starting_direction = starting_position.split(" ")
    puts "Setting starting position to #{starting_x} #{starting_y} facing #{starting_direction}..."
    @x = starting_x.to_i
    @y = starting_y.to_i
    @direction = starting_direction.intern
    self
  end

  def parse_instructions(instructions)
    instructions.chars.each do |instruction|
      case instruction
      when "M"
        puts "Moving forward..."
        x_delta, y_delta = DELTAS[@direction]
        @x += x_delta if 0 <= @x + x_delta and @x + x_delta <= @grid_width
        @y += y_delta if 0 <= @y + y_delta and @y + y_delta <= @grid_height
      when "L"
        puts "Turning left..."
        @direction = DIRECTIONS.rotate!(-1).first
      when "R"
        puts "Turning right..."
        @direction = DIRECTIONS.rotate!(1).first
      end
    end
    self
  end
end
