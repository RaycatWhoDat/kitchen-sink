use Text::CSV;

my $parser = Text::CSV.new;
my $file = "./MOCK_DATA.csv".IO;
my $parser = CSV::Parser.new(file_handle => $file, contains_header_row => True);
my @lines = $csv.getline_all($file);
