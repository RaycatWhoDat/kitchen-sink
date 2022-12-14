require "./game_state"

game = GameState.new;
loop { game.handle_commands }
