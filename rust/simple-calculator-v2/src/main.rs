use std::io;

#[derive(Debug)]
struct State {
    last_result: f32,
    pending_expressions: Vec<String>
}

impl State {
    fn ask_for_input(&mut self) {
        println!("Last result: {}", self.last_result);
        print!("Please enter arithmatic expressions separated by spaces: ");
        
        let mut buffer = String::new();
        let mut pending_expressions = vec![];
        match io::stdin().read_line(&mut buffer) {
            Ok(_) => {
                buffer
                    .trim()
                    .split(" ")
                    .for_each(|item| pending_expressions.push(String::from(item)));
            }
            Err(_) => pending_expressions.push(String::from(""))
        }
        self.pending_expressions = pending_expressions;
    }
    
    fn calculate(&mut self) {
        if self.pending_expressions.len() < 2 { return; }
        self.last_result = self.pending_expressions[0]
            .parse::<f32>()
            .unwrap_or_default();
        
        for index in (1..self.pending_expressions.len()).step_by(2) {
            if index == self.pending_expressions.len() { continue }

            let item1 = self.pending_expressions[index].as_str();
            let item2 = self.pending_expressions[index + 1].as_str();
            
            match item1 {
                "+" => { self.last_result += item2.parse::<f32>().unwrap_or_default(); },
                "-" => { self.last_result -= item2.parse::<f32>().unwrap_or_default(); },
                "*" => { self.last_result *= item2.parse::<f32>().unwrap_or_default(); },
                "/" => { self.last_result /= item2.parse::<f32>().unwrap_or_default(); },
                _ => println!("Unknown!")
            }
        }
    }
}

fn main() {
    println!("=== Calculator ===");
    
    let mut state = State {
        last_result: 0.0,
        pending_expressions: vec![]
    };

    loop {
        state.ask_for_input();
        state.calculate();
    }
}

