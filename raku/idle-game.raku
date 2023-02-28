constant @EXP-CURVE = 0, 5, 10, * + 5 ... *;

class Adventurer {
    has Str $.name;
    has Int $.level = 1;
    has Int $.experience-points = 0;
    has Int $.experience-cap = 100;
    has $.timer = Supply.interval(1);
    has $!subscription = $!timer.tap: {
        $!experience-points += 50 - (5 * $!level);
        if $!experience-points >= $!experience-cap {
            $!level += 1;
            $!experience-points = 0;
            $!experience-cap += [+] @EXP-CURVE[^$!level];
        }
    };

    method gist(--> Str) {
        "{$!name} - LV {$!level} - EXP: {$!experience-points}"
    }
}

my @adventurers = Adventurer.new(name => "John Testman 1");
sleep 0.5;
@adventurers.push: Adventurer.new(name => "John Testman 2");

react whenever Supply.interval(1) {
    .say for @adventurers;
};
