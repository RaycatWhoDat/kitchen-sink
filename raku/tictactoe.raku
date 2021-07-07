enum NaughtOrCross <O X>;

class Square {
    has NaughtOrCross $.value;
    method Str { $.value.Str }
}

my @board[9] = [Square.new(value => $_ %% 2 ?? O !! X) for ^9];

sub board-row(@board where .elems == 3) { "@board[0] | @board[1] | @board[2]" }
sub board-separator { "\n--+---+--" }

say board-row(@board[0..2]) ~ board-separator;
say board-row(@board[3..5]) ~ board-separator;
say board-row(@board[6..8]);
