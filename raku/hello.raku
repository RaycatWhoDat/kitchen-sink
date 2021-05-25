my Str $name;

loop {
    $name = prompt("What is your name? ").trim;
    last if $name.chars > 0;
    say "Please enter a name.";
} 

say "Hello, $name, nice to meet you.";
say "$name is {$name.chars} characters long.";

