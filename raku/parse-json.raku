my @data = "../txr/stack-trace.json".IO.lines;
for @data -> $line {
    my @matches = $line ~~ m:g/ \" (.+) \" ':' (.+) /;
    say ~$/[0].head if $/;
}
