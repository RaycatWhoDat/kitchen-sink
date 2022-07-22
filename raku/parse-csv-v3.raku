use Text::CSV;

my @data = csv(in => "./MOCK_DATA.csv");

.say for @data;

