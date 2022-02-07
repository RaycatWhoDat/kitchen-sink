use std::io;
use std::io::Write;
use rand::seq::SliceRandom;

#[derive(Clone)]
struct Guess {
    word: Vec<char>,
    letters: [bool; 5],
    positions: [bool; 5]
}

impl Guess {
    fn is_correct(&self) -> bool {
       self.positions.iter().all(|position| *position)
    }
}

struct GameState {
    chosen_word: Vec<char>,
    guesses: Vec<Guess>
}

fn read_line() -> Option<String> {
    let mut buffer = String::new();
    io::stdin().read_line(&mut buffer).unwrap();
    buffer.truncate(5);
    buffer = String::from(buffer.trim());
    if buffer.len() < 5 {
        println!("Sorry! You can only guess 5-letter words.");
        None
    } else {
        Some(buffer)
    }
}

fn main() {
    let ansi_reset = "\x1B[0m";
    let ansi_green = "\x1B[30;1m\x1B[42m";
    let ansi_yellow = "\x1B[30;1m\x1B[43m";
    let ansi_red = "\x1B[31m\x1B[40m";

    let mut random_words = vec![
        "shard",
        "piece",
        "tower",
        "those",
        "moist",
        "apple",
        "onion",
        "spoon",
        "knife",
        "aloft"
    ];

    let mut rng = rand::thread_rng();
    random_words.shuffle(&mut rng);
    let chosen_word = random_words[0];
    
    let mut state = GameState {
        chosen_word: chosen_word.chars().collect(),
        guesses: vec![]
    };

    println!("Werdle!");
    loop {
        let input: String;

        loop {
            print!("Please enter a word: ");
            io::stdout().flush().expect("Something went horribly wrong.");
            if let Some(raw_input) = read_line() {
                input = raw_input;
                break;
            } 
        }

        let mut guess = Guess {
            word: input.chars().collect(),
            letters: [false; 5],
            positions: [false; 5]
        };

        let mut valid_letters = state.chosen_word.clone();

        // Check word here.
        for (index, letter) in guess.word.iter().enumerate() {
            let is_valid_position = state.chosen_word[index] == *letter;
            let is_valid_letter = is_valid_position || valid_letters.iter().any(|valid_letter| valid_letter == letter);
            if is_valid_position || is_valid_letter {
                valid_letters.retain(|valid_letter| valid_letter != letter);
            };
            
            guess.letters[index] = is_valid_letter;
            guess.positions[index] = is_valid_position;
        }
        
        state.guesses.push(guess.clone());

        println!("===============");
        print!("Guess #{}: ", state.guesses.len());
        for (index, letter) in guess.word.iter().enumerate() {
            let ansi_color = if guess.positions[index] {
                ansi_green
            } else if guess.letters[index] {
                ansi_yellow
            } else {
                ansi_red
            };

            print!("{}{}{}", ansi_color, letter, ansi_reset);
        }
        print!("\n===============\n");
        
        if guess.is_correct() {
            println!("Congratulations! You've guessed the word!");
            break;
        } else {
            if state.guesses.len() >= 6 {
                println!("Sorry! You didn't guess the word in six tries.");
                println!("The word was: {}", state.chosen_word.iter().collect::<String>());
                break;
            }
        }
    }
}
