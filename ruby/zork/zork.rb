require "./game_state"

game = GameState.new;
loop do
  game.handle_commands
end
