my @data = "../txr/stack-trace.json".IO.lines;
for @data -> $line {
    my @matches = $line ~~ m:g/ <same> (.+) ': ' <same> (.+) /;
    say ~$/.first[0] if $/
}
