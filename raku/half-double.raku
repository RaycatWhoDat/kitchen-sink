my Int $first-number = prompt "What is the first number? ";
my Int $second-number = prompt "What is the second number? ";

.say for ($first-number, * div 2 ... * <= 1) Z ($second-number, * * 2 ... *);
