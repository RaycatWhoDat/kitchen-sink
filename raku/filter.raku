my @numbers = prompt "Enter a list of numbers, separated by spaces: ";
my @even-numbers = @numbers.split(' ').grep: * %% 2;
say "The even numbers are: {@even-numbers}";
