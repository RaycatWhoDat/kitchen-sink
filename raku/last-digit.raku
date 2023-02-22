sub last-digit(Str $_) { m:g/ <digit> /; ~$/.tail }

say last-digit("Buy 1 get 2 free");
