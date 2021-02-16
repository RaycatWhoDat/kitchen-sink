fn prompt_for_float() -> f32 {
    loop {
        let mut buffer = String::new();
        std::io::stdin().read_line(&mut buffer).ok();
        if let Ok(number) = buffer.trim().parse::<f32>() {
            break number;
        } else {
            println!("Please enter a valid number.");
        }
    }
}

fn main() {
    println!("What is the bill amount? ");
    let bill_amount = prompt_for_float();

    println!("What is the tip percentage? ");
    let tip_percentage = prompt_for_float();
    
    let tip_amount = tip_percentage / 100.0 * bill_amount;
    let total_amount = bill_amount + tip_amount;
    
    println!("Your tip amount is ${:.2}.", tip_amount);
    println!("Your total is ${:.2}.", total_amount);
}
