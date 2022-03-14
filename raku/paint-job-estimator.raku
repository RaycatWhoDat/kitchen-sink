constant UNIT-OF-WORK = 115;
constant NUMBER-OF-HOURS-REQUIRED = 8;
constant COST-PER-HOUR = 20;

my $space-painted;
my $price-of-paint;

until $space-painted ~~ Real {
    $space-painted = prompt "How many square feet painted? ";
}

until $price-of-paint ~~ Real {
    $price-of-paint = prompt "How much did paint cost? ";
}

my $number-of-gallons = $space-painted / UNIT-OF-WORK;
my @headings = "Gallons of paint required: ", "Hours of labor required: ", "Cost of paint: ", "Cost of labor: ", "Total cost of job: ";
my @costs = $number-of-gallons, $number-of-gallons * 8, $number-of-gallons * $price-of-paint, $number-of-gallons * 8 * COST-PER-HOUR;
@costs.push: [+] @costs;

say .[0], .[1] for @headings Z @costs;                                   
