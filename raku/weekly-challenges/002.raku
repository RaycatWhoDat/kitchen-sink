use v6;

sub infix:<D>(Int $input, Int $divisor) is assoc<left> {
    ($input div $divisor, $input % $divisor)
}

sub remove-leading-zeros(Str $input) { $input.Int.Str; }
multi convert-base10-base35(Int(Str) $input, :$to) { $input.base: 35 }
multi convert-base10-base35(Int(Str) $input, :$from) { :35($input) }

DOC CHECK {
    use Test;

    subtest "Remove leading zeroes" => {
        my $input = "00001234";
        remove-leading-zeros($input).&is("1234");
    }
    
    subtest "Base10 to Base35 (No-Z) conversions" => {
        my $input = "A";
        convert-base10-base35($input, :from).&is("10");
        convert-base10-base35("10", :to).&is("A");
    }
}
