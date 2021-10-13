class Memory {
    has byte @!data[8];

    method get-data { @!data }

    method get-integer-value {
        [+] ((1 +< (7 - $_)) if @!data[$_] == 1 for @!data.keys)
    }
    
    method set-integer-value(byte $number) {
        my $count = $number;
        for @!data.keys {
            my $place = (1 +< (7 - $_));
            my $result = $count >= $place;
            $count -= $place if $result;
            @!data[$_] = +$result;
        }
    }
}

DOC CHECK {
    use Test;

    my $memory = Memory.new;

    $memory.get-data.&is(0 xx 8);
    $memory.set-integer-value(6);
    $memory.get-data.&is([0,0,0,0,0,1,1,0]);
    $memory.get-integer-value.&is(6);
    
    done-testing;
}
