enum NaughtOrCross <O X>;

class Square {
    has NaughtOrCross $.value;
    method Str { $.value.Str }
}

my @board[9] = [Square.new(value => $_ %% 2 ?? O !! X) for ^9];

say "@board[0] | @board[1] | @board[2]\n--+---+--";
say "@board[3] | @board[4] | @board[5]\n--+---+--";
say "@board[6] | @board[7] | @board[8]";
