use std::io;
use std::cmp::Ordering;
use rand::Rng;

enum Guess {
    Higher,
    Equal,
    Lower
}

struct SecretNumber {
    value: i32
}

impl SecretNumber {
    fn compare_guess(&self, guess: &i32) -> Guess {
        let guess_result = match guess.cmp(&self.value) {
            Ordering::Greater => Guess::Higher,
            Ordering::Equal => Guess::Equal,
            Ordering::Less => Guess::Lower
        };

        match guess_result {
            Guess::Higher => println!("Lower."),
            Guess::Lower => println!("Higher."),
            _ => ()
        }

        guess_result
    }
}

fn main() {
    println!("Guess The Number");
    println!("================");

    let secret_number = SecretNumber {
        value: rand::thread_rng().gen_range(1, 101)
    };
    
    loop {
        let mut guess = String::new();
        
        println!("Enter a number between 1 and 100: ");
        
        io::stdin()
            .read_line(&mut guess)
            .expect("Failed to read line");

        let guess = guess.trim().parse::<i32>().unwrap();
        
        match secret_number.compare_guess(&guess) {
            Guess::Equal => {
                println!("You guessed it!");
                break;
            },
            _ => ()
        }
    }
}
