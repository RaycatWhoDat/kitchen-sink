my @names = <Allen Bob Carmen Diane Ethel Fred>;
my @ids = 123, 321, 435, 234, 565, 345;

# Later on...

my %mapping = @names Z=> @ids;

say %mapping;
