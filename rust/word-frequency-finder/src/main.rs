use std::fs;
use std::collections::HashMap;

fn main() {
    // Initalize dict
    let mut found_words: HashMap<&str, usize> = HashMap::new();

    // Read file (stream file)
    let raw_words = fs::read_to_string("../../words.txt").expect("Something went wrong while reading the file.");
    let split_words: Vec<&str> = raw_words.split(" ").collect();

    // Upsert keys and increment
    for word in split_words {
        let word = word.trim();
        if word.len() == 0 { continue; }
        let word_entry = found_words.entry(word).or_insert(0);
        *word_entry += 1;
    }

    // Print results
    for (word, count) in found_words {
        println!("{}: {}", word, "*".repeat(count));
    }
}
