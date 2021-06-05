enum UserType <Guest Customer Admin>;

class User { has Str $.name; has UserType $.type; }

my @allUsers = ("Adam", Guest), ("Ben", Customer), ("Charlie", Admin);

say User.new(name => .head, type => .tail).name for @allUsers;
