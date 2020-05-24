use v6;

sub toChineseNumeral(Int $number = 0) {
    my $numerals = <零 一 二 三 四 五 六 七 八 九>;
    my $places = $number.polymod(10, 10, 10, 10).reverse;
    my Str $numbers = join "", do for ^4 {
        my Int $number = $places[$_];
        next if $number == 0;
        $numerals[$number] ~ <万 千 百 十>[$_];
    }

    given $number {
        when 0..9 { $numerals[$places.tail] }
        when 10 { $numbers.substr(1) }
        when 11..19 { $numbers.substr(1) ~ $numerals[$places.tail] }
        default { $numbers ~ $numerals[$places.tail] }
    }
}
    
sub MAIN() {
    for [9, 10, 11, 18, 21, 110, 111, 123, 1000, 10000, 24681] {
        say $_ ~ ": " ~ toChineseNumeral($_)
    }
}
