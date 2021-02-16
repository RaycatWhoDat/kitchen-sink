use v6;

subset DollarAmount of Cool where /^ <[0..9.]>+ $/;
subset Percentage of Numeric where * > 1;

my $bill-amount; 
my $tax-percentage; 

loop {
    $bill-amount = prompt "What is the bill amount? ";
    last if $bill-amount ~~ DollarAmount; 
    say "Please enter a valid number.";
}

loop {
    $tax-percentage = prompt "What is the tip percentage? ";
    last if $tax-percentage ~~ Percentage;
    say "Please enter a valid percentage.";
}

my $tip-amount = ($tax-percentage / 100 * $bill-amount).round: 0.01;

say "The tip amount is \$$tip-amount.";
say "The total amount is \$", $bill-amount + $tip-amount, ".";
