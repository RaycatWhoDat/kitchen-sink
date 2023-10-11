use rand::prelude::*;

struct State {
    number_of_players: i32,
    rng: ThreadRng
}

impl State {
    fn new() -> Self {
        State {
            number_of_players: 0,
            rng: thread_rng()
        }
    }
}

struct Player {
    name: String,
    last_roll: i32
}

impl Player {
    fn new(state: &mut State) -> Self {
        state.number_of_players += 1;
        Player {
            name: format!("Player {}", state.number_of_players),
            last_roll: 1000
        }
    }

    fn roll(&mut self, state: &mut State, starting_number: i32) {
        self.last_roll = state.rng.gen_range(1..starting_number);
        println!("Random! {} rolls a {} (out of {}).", self.name, self.last_roll, starting_number);
    }
}

fn main() {
    let mut state = State::new();
    let mut current_player = Player::new(&mut state);
    let mut other_player = Player::new(&mut state);

    while other_player.last_roll != 1 {
        current_player.roll(&mut state, other_player.last_roll);
        std::mem::swap(&mut current_player, &mut other_player);
    }

    println!("Game over! {} wins!", current_player.name);
}
