use std::io::{stdin, stdout, Write, Result};

enum Token {
    Any
}

#[derive(Clone)]
struct Reader {
    original_input: String,
    tokens: Vec<String>,
    position: usize
}

impl Reader {
    fn peek(&self) -> String  {
        let character = self.original_input.as_bytes()[self.position];
        character.to_string()
    }
    fn next(&mut self) -> String {
        let character = self.peek();
        self.position += 1;
        character.to_string()
    }
}

fn tokenize(input: String) -> Reader {
    let reader = Reader {
        original_input: input,
        tokens: [].to_vec(),
        position: 0
    };

    reader
}

fn read_form(reader: Reader) -> String {
    reader.original_input
}

fn read_str(input: String) -> String {
    read_form(tokenize(input))
}
fn read(input: String) -> String { read_str(input) }

fn eval(ast: String) -> String { ast }

fn print_str(output: String) -> String { output }
fn print(output: String) -> String { print_str(output) }

fn rep() -> Result<()> {
    loop {
        let mut buffer = String::new();
        print!("user> ");
        stdout().flush().expect("Failed to print.");
        stdin().read_line(&mut buffer)?;
        println!("{}", print(eval(read(buffer))));
    }

    #[allow(unreachable_code)]
    Ok(())
}

fn main() -> Result<()> {
    rep()
}
