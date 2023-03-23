my @numbers = 1..5;
my @fruits = <Apple Banana Cherry Date Fig>;

sub cycle(@sequence) { |@sequence xx * }
sub print-item($item) { say "$item"; }

print-item($_) for cycle(@numbers)[^20];
print-item($_) for cycle(@fruits)[^20];

say "$_[0]: $_[1]" for cycle( zip(@numbers, @fruits))[^20];
