enum Symbols <_ O X>;

my @winning-positions = (0, 1, 2), (3, 4, 5), (6, 7, 8), (0, 4, 8), (2, 4, 6), (0, 3, 6), (1, 4, 7), (2, 5, 8);

class Square {
    has Symbols $.value;
    
    method Str { ~$.value }
    method Numeric { +$.value }
}

class Board {
    has @.squares = [Square.new(value => Symbols.pick) for ^9];

    method gist { @.squares.map({ ~$_ }); }
    method get-squares(@positions) { @.squares[|@positions].map({ +$_ }); }
}

my $board = Board.new;

sub display-board(@board) {
    .say for "@board[0] | @board[1] | @board[2]",
    "--+---+--",
    "@board[3] | @board[4] | @board[5]",
    "--+---+--",
    "@board[6] | @board[7] | @board[8]";
}

sub find-win($board) {
    my $winning-lines = [];
    for @winning-positions -> $position {
        my $result = $board.get-squares($position).cache;
        $winning-lines.push: $result.first, $position if $result.Bag.elems == 1 and 0 ∉ $result;
    }
    $winning-lines;
}

display-board($board.gist);
say find-win($board);
