use std::io;

fn get_message() -> String {
    let mut message = String::new();
        
    println!("Enter your secret message.");
        
    io::stdin()
        .read_line(&mut message)
        .expect("Failed to read line");

    message.trim().to_string()
}

fn translate(message: &String, source: &Vec<char>, destination: &Vec<char>) -> String {
    let mut new_message = String::new();

    for character in message.chars() {
        if let Some(index) = source.iter().position(|item| character == *item) {
            let new_character = &destination.iter().nth(index).unwrap();
            new_message += &new_character.to_string();
        } else {
            new_message += &character.to_string();
        }
    }

    new_message
}

fn main() {
    let alphabet: Vec<char> = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".chars().collect();
    let key: Vec<char> = "XZNLWEBGJHQDYVTKFUOMPCIASRxznlwebgjhqdyvtkfuompciasr".chars().collect();

    let secret_message = get_message();
    let encrypted_message = translate(&secret_message, &alphabet, &key);
    let decrypted_message = translate(&encrypted_message, &key, &alphabet);

    println!("Encrypted message: {}", encrypted_message);
    println!("Decrypted message: {}", decrypted_message);
}
