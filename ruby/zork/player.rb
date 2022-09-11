class Player
  attr_accessor :name, :level, :current_room

  def initialize
    print "What is your name? "
    @name = gets.chomp
    @level = 1
  end

  def status
    puts "You are #@name, a Level #@level adventurer."
    puts "You are currently in #{@current_room.name}."
    puts @current_room.description if @current_room.description
  end
end
