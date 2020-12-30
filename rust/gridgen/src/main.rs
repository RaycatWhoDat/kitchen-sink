use std::env;

enum LineOrBreak {
    Line,
    Break
}

fn draw_row(columns: i32, lob: LineOrBreak) {
    let delimiters = match lob {
        LineOrBreak::Line => ["|", " "],
        LineOrBreak::Break => ["+", "-"]
    };

    for _ in 0..columns {
        print!("{}", delimiters[0]);
        print!("{}", delimiters[1].repeat(4));
    }
    
    println!("{}", delimiters[0]);
}

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() < 2 { return }
    
    if let [_, columns, ..] = args.as_slice() {
        let columns = columns.parse().unwrap();
        for _ in 0..columns {
            draw_row(columns, LineOrBreak::Break);
            draw_row(columns, LineOrBreak::Line);
        }
        
        draw_row(columns, LineOrBreak::Break);
    }
}
