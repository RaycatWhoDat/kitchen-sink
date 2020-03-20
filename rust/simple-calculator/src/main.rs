use std::io;

fn main() {
    let mut input = String::new();

    println!("Enter a list of numbers separated by spaces:");
    io::stdin().read_line(&mut input).unwrap();
    let numbers = input
        .split(" ")
        .filter_map(|fragment| fragment.parse::<f64>().ok());

    println!("{}", numbers.sum::<f64>());
}
