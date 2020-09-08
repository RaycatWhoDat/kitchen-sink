use std::io::{BufRead, BufReader, Lines, Result};
use std::fs::File;

fn read_lines(file: File) -> Lines<BufReader<File>> {
    return BufReader::new(file).lines();
}

fn main() -> Result<()> {
    let numbers = read_lines(File::open("formatted_numbers.txt")?);
    let texts = read_lines(File::open("formatted_text.txt")?);
    let kinds = read_lines(File::open("formatted_types.txt")?);

    for ((number, text), kind) in numbers.zip(texts).zip(kinds)  {
        println!("{}|{}|{}", number?, text?, kind?);
    }
    
    Ok(())
}
