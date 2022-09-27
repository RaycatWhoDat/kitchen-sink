class DirectionGetter
  attr_accessor :directions

  def initialize directions
    directions.each_with_index do |direction, index|
      define_singleton_method("get_#{direction.to_s}") { directions[index] }
    end
    
    @directions = directions
  end
end

class DirectionShuffler < DirectionGetter
  def initialize
    super [:north, :east, :south, :west].shuffle
  end
end
  
direction_getter = DirectionShuffler.new
p direction_getter.directions
p direction_getter.get_north
