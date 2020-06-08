subset NotNegative of Int where * >= 0;

# subset GreaterThanZero of Int where * > 0;
# multi ack(0, $n) { $n + 1 }
# multi ack(GreaterThanZero $m, 0) { ack($m - 1, 1) }
# multi ack(GreaterThanZero $m, GreaterThanZero $n) { ack($m - 1, ack($m, $n - 1)) }

sub ack(NotNegative $m, NotNegative $n) {
    return $n + 1 if $m == 0;
    return ack($m - 1, 1) if $m > 0 && $n == 0;
    return ack($m - 1, ack($m, $n - 1));
}

sub MAIN(NotNegative $m, NotNegative $n) { say ack $m, $n; }
