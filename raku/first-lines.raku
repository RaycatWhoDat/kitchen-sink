use v6;

for $*ARGFILES.handles {
    say "\n" ~ .Str ~ "\n==========";
    .lines.head.say;
}
