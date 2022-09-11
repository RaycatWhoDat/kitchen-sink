require "./game_map"
require "./player"

$explore_regex = /^EXPLORE (?<direction>NORTH|EAST|SOUTH|WEST)$/i;
$move_regex = /^MOVE (?<direction>NORTH|EAST|SOUTH|WEST)$/i;
$sys_regex = /^EXIT$/i;

class GameState
  attr_accessor :map, :player, :last_command

  def initialize
    @map = GameMap.new
    @player = Player.new
    @player.current_room = @map.starting_room
  end

  def handle_commands
    @player.status
    exits = @player.current_room.exits.map { |sym| sym.to_s.upcase }
    expeditions = @player.current_room.expeditions.map { |sym| sym.to_s.upcase }
    puts "You may MOVE #{exits.join('/')}." unless exits.empty?
    puts "You may EXPLORE #{expeditions.join('/')}." unless expeditions.empty?

    next_command = nil
    loop do
      print "What is your command? "
      next_command = gets.chomp
      break if next_command.match?($move_regex) or next_command.match?($explore_regex) or next_command.match?($sys_regex)
      puts "That is an invalid command."
    end

    @last_command = next_command
    case last_command
    when $move_regex
      @player.current_room = @player.current_room.rooms[$~[:direction].downcase.intern] if exits.include?($~[:direction].upcase)
    when $explore_regex
      @player.current_room = @map.generate_unexplored_room(@player.current_room, $~[:direction].downcase.intern)
    when $sys_regex
      exit
    end
  end
end
