// Take and sanitize input from user
// Split input into array
// Check each character
// true/false?

use std::io;
use std::io::Write;

fn read_line() -> Option<String> {
    let mut buffer = String::new();
    io::stdin().read_line(&mut buffer).unwrap();
    buffer = String::from(buffer.trim());
    Some(buffer)
}

fn get_word(number: u8) -> String {
    let input: String;
    
    loop {
        print!("Please enter word {}: ", number);
        io::stdout().flush().expect("Something went horribly wrong.");
        if let Some(raw_input) = read_line() {
            input = raw_input;
            break;
        } 
    }

    input
}

fn main() {
    let mut word1: Vec<_> = get_word(1).chars().collect();
    word1.sort();
    let mut word2: Vec<_> = get_word(2).chars().collect();
    word2.sort();
    
    if word1.cmp(&word2).is_eq() {
        println!("Anagrams!");
    } else {
        println!("Not anagrams...");
    }
}
