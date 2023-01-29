use Test;

my @test-cases = <lumberjacks background downstream six-year-old isograms>;

sub is-isogram($_) {
    my $chars = .comb.grep(* !~~ / ' '|'-' /).cache;
    $chars.Bag ~~ $chars.Set.Bag
}

@test-cases.map(&is-isogram).&is((True, True, True, True, False))
