subset PositiveInt of Int where * > 0;

sub prompt-for-sides {
    my PositiveInt $side1 = prompt "Enter a value for the first side: ";
    my PositiveInt $side2 = prompt "Enter a value for the second side: ";
    my PositiveInt $side3 = prompt "Enter a value for the third side: ";
    ($side1, $side2, $side3);
}

sub is-triangle(PositiveInt $side1, PositiveInt $side2, PositiveInt $side3) {
    ($side1 + $side2 < $side3,
     $side1 + $side3 < $side2,
     $side2 + $side3 < $side1).none;
}

sub MAIN() {
    say is-triangle(|prompt-for-sides) ?? "Yes" !! "No";
}
