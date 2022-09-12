class Room
  @@number_of_rooms = 0
  
  attr_accessor :name, :description, :rooms
  
  def initialize name:, description: "Room \##{@@number_of_rooms += 1}", rooms: {}
    @name = name
    @description = description
    @rooms = rooms
  end

  def exits
    @rooms.keys.sort
  end

  def expeditions
    [:north, :east, :south, :west] - @rooms.keys
  end
end
