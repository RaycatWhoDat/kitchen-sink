class Player
  @@number_of_players = 0

  attr_accessor :name, :last_roll
  
  def initialize
    @@number_of_players += 1
    @name = "Player #{@@number_of_players}"
    @last_roll = 1000
  end

  def roll starting_roll
    @last_roll = rand(1..starting_roll).floor
    puts "Random! #{@name} rolls a #{@last_roll} (out of #{starting_roll})."
  end
end

current_player, other_player = Player.new, Player.new

until other_player.last_roll == 1 do
  current_player.roll other_player.last_roll
  current_player, other_player = other_player, current_player
end

puts "#{current_player.name} wins!"
