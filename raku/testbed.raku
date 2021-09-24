enum UserType <Guest Customer Admin>;

class User { has Str $.name; has UserType $.type; }

my @all-users = (User.new(name => .head, type => .tail) for ("Adam", Guest), ("Ben", Customer), ("Charlie", Admin));

my $username = prompt "What is the user's name? ";
@all-users.push: User.new(name => $username, type => Guest) if $username;
.name.say for @all-users;
