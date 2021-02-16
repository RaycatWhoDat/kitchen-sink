fn main() {
    println!("What is your name?");
    let mut buffer = String::new();
    let name = loop {
        std::io::stdin().read_line(&mut buffer).ok();
        let name = buffer.trim();
        if name.len() >= 1 {
            break name;
        } else {
            println!("Please enter a name.");
        }
    };
                
    println!("Hello, {}, nice to meet you.", name);
    println!("{} is {} characters long.", name, name.len());
}
