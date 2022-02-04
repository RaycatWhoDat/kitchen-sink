use std::io;
use std::io::Write;

#[derive(Clone)]
struct Guess {
    word: String,
    letters: [bool; 5],
    positions: [bool; 5]
}

impl Guess {
    fn is_correct(&self) -> bool {
        let mut is_correct = true;
        for position in &self.positions {
            if !position {
                is_correct = false;
                break;
            }
        }
        is_correct
    }
}

struct GameState {
    chosen_word: String,
    valid_letters: Vec<String>,
    guesses: Vec<Guess>
}

fn read_line() -> String {
    let mut buffer = String::new();
    io::stdin().read_line(&mut buffer).unwrap();
    buffer.truncate(5);
    String::from(buffer.trim())
}

fn main() {
    let ansi_reset = String::from("\x1B[0m");
    let ansi_green = String::from("\x1B[30;1m\x1B[42m");
    let ansi_yellow = String::from("\x1B[30;1m\x1B[43m");
    let ansi_red = String::from("\x1B[31m\x1B[40m");
    
    let mut state = GameState {
        chosen_word: String::from("shard"),
        valid_letters: vec![],
        guesses: vec![]
    };

    for character in state.chosen_word.chars() {
        state.valid_letters.push(String::from(character));
    }
    
    println!("Werdle!");
    loop {
        print!("Please enter a word: ");
        io::stdout().flush().expect("Something went horribly wrong.");
        let input = read_line();

        let mut guess = Guess {
            word: input,
            letters: [false; 5],
            positions: [false; 5]
        };

        // Check word here.
        for (index, character) in guess.word.chars().enumerate() {
            let letter = String::from(character);
            let is_valid_position = state.chosen_word.get(index..=index).unwrap() == letter;
            let is_valid_letter = is_valid_position || state.valid_letters.contains(&letter);
            guess.letters[index] = is_valid_letter;
            guess.positions[index] = is_valid_position;
        }
        
        state.guesses.push(guess.clone());

        println!("===============");
        print!("Guess #{}: ", state.guesses.len());
        for (index, letter) in guess.word.chars().enumerate() {
            if guess.positions[index] {
                print!("{}{}{}", ansi_green, letter, ansi_reset);
            } else if guess.letters[index] {
                print!("{}{}{}", ansi_yellow, letter, ansi_reset);
            } else {
                print!("{}{}{}", ansi_red, letter, ansi_reset);
            }
        }
        print!("\n===============\n");
        
        if guess.is_correct() {
            println!("Congratulations! You've guessed the word!");
            break;
        } else {
            if state.guesses.len() >= 6 {
                println!("Sorry! You didn't guess the word in six tries.");
                break;
            }
        }
    }
}
