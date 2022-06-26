use HTTP::Tiny;
use JSON::Tiny;

my $response = HTTP::Tiny.new.get("http://api.open-notify.org/astros.json");
my %astronauts = from-json($response{"content"}.decode);
printf("%25s | %10s\n", .{"name"}, .{"craft"}) for ({ craft => "CRAFT", name => "NAME" }, |%astronauts{"people"}[]);
