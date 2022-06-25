fn main() {
    const MAX_NUMBER: i32 = 12;

    print!("{:>3} ", "");
    
    let numbers = (0..MAX_NUMBER + 1)
        .map(|number| {
            print!("{:>3} ", number);
            number
        })
        .collect::<Vec<i32>>();

    println!();
    
    for number1 in &numbers {
        print!("{:>3} ", number1);

        for number2 in &numbers {
            print!("{:>3} ",  number1 * number2);
        }
        
        println!();
    }
}
