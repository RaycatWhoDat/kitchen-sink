constant NUMBER_OF_ITEMS = 100;
my $ratios =  ({ (-1, 0, 1).pick } ... *)[^NUMBER_OF_ITEMS].Bag;
for $ratios.kv -> $key, $value { say "$key: {$value / 100}" }
