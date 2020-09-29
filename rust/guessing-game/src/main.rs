use std::io;
use rand::Rng;

fn main() {
    println!("Guess The Number");
    println!("================");

    let secret_number = rand::thread_rng().gen_range(1, 101);
    println!("The secret number is {}", secret_number);
    
    loop {
        let mut guess = String::new();
        
        println!("Enter a number between 1 and 100: ");
        
        io::stdin()
            .read_line(&mut guess)
            .expect("Failed to read line");

        if guess.trim().parse::<i32>().unwrap() == secret_number {
            println!("You guessed it!");
            break;
        } else {
            println!("Sorry, that's not the number");
        }
    }
    
}

