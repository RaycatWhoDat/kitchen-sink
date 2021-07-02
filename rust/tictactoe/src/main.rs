#[derive(Clone, Copy, Debug)]
enum NaughtOrCross {
    NAUGHT,
    CROSS
}

#[derive(Clone, Copy)]
struct Square {
    value: Option<NaughtOrCross>
}

type Board = [Square; 9];

fn format_value(square: Square) -> String {
    match square.value.unwrap() {
        NaughtOrCross::NAUGHT => String::from("O"),
        NaughtOrCross::CROSS => String::from("X")
    }
}

fn main() {
    let mut board: Board = [Square { value: None }; 9];

    for index in 0..board.len() {
        board[index].value = if index % 2 == 0 {
            Some(NaughtOrCross::NAUGHT)
        } else {
            Some(NaughtOrCross::CROSS)
        };
    }
    
    println!("{} | {} | {}\n--+---+--", format_value(board[0]), format_value(board[1]), format_value(board[2]));
    println!("{} | {} | {}\n--+---+--", format_value(board[3]), format_value(board[4]), format_value(board[5]));
    println!("{} | {} | {}", format_value(board[6]), format_value(board[7]), format_value(board[8]));
}
