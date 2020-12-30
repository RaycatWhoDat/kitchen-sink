use v6;

grammar NetstatReport {
    rule TOP {
        <value>*
    }
    rule value {
        <[\S]>+
    }
}

my $netstatCommand = run 'netstat', '-vanp', 'tcp', :out;
my $grepCommand = run 'grep', '5432', :in($netstatCommand.out), :out;
my $output = $grepCommand.out.slurp: :close;
my $pid = NetstatReport.parse($output)<value>[8].trim;

say "Killing PID $pid.";

