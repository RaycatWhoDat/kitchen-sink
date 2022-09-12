require "./room"

class GameMap
  attr_accessor :starting_room

  def initialize
    seed_room = Room.new(name: "Ye Olde Tavern", description: "There's nothing here but ale.")
    test_room = Room.new(name: "The Back Room", description: "This is another room.", rooms: { :south => seed_room })
    seed_room.rooms = { :north => test_room }
    @starting_room = seed_room
  end

  def get_opposite_direction direction
    { :north => :south, :east => :west, :south => :north, :west => :east }[direction]
  end

  def generate_unexplored_room previous_room, direction
    name = ("a".."z").to_a.sample(15).join
    opposite_direction = get_opposite_direction(direction)
    new_room = Room.new(name: name, rooms: { opposite_direction => previous_room })
    previous_room.rooms[direction] = new_room
  end
end
