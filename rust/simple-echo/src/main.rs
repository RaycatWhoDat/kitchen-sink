use std::env;

fn main() {
    let parameters = {
        let all_args: Vec<String> = env::args().collect();
        all_args[1..].to_vec()
    };

    println!("{:?}", parameters);
}
