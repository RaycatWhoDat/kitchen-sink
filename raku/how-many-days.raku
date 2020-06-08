sub MAIN() {
    my Int $seconds = prompt "Enter the number of seconds: ";
    my @units = $seconds.abs.polymod(60, 60, 24).reverse;
    say "%d == %d days, %d hours, %d minutes, and %d seconds.".sprintf($seconds, |@units);
}
