enum UserType <Guest Customer Admin>;

class User {
    has Str $.name;
    has UserType $.type;
}

my $testUser1 = User.new(name => "Adam", type => Guest);
my $testUser2 = User.new(name => "Ben", type => Customer);
my $testUser3 = User.new(name => "Charlie", type => Admin);

.name.say for $testUser1, $testUser2, $testUser3;
