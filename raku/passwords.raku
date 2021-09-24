subset ValidUsername of Str where /^^ <graph>+ $$/;
subset ValidPassword of ValidUsername where .chars >= 8;

my ValidUsername $username;
my ValidPassword $password;

loop {
    try { $username = prompt "Please enter your username: "; }
    try { $password = prompt "Please enter your password: "; }
    last if $username and $password;
    say "Sorry, try again.";
}

if $username eqv "username" and $password eqv "password" {
    say "Welcome back.";
} else {
    say "Wanna sign up?";
}


