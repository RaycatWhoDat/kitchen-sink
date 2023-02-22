subset ValidUserId of Str where * ~~ / <digit> <alpha> ** 3 <digit>+ /;

sub is-valid(Str $_) { m/ <digit> <alpha> ** 3 <digit>+ / };

printf("User ID is %s.", is-valid("42NJD03193") ?? "valid" !! "invalid");
