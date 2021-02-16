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
    println!("What is the first number?");
    let first_number = prompt_for_float();

    println!("What is the second number?");
    let second_number = prompt_for_float();

    let operations: &[(&str, fn(f32, f32) -> f32)] = &[
        ("+", | num1, num2 | num1 + num2),
        ("-", | num1, num2 | num1 - num2),
        ("*", | num1, num2 | num1 * num2),
        ("/", | num1, num2 | num1 / num2)
    ];
    
    for (name, function) in operations.iter() {
        println!("{} {} {} = {}", first_number, name, second_number, function(first_number, second_number));
    }
}
