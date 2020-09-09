use v6;

grammar DiskUsage {
    rule TOP {
        <record>+ %% \n
    }

    token record {
        <usage> <blank> <path>
    }

    token usage {
        <value>
    }
    
    token value {
        \d+ [\.\d+]?
    }

    token unit {
        B|K|M|G
    }

    token path {
        \H+
    }
}

my $command = run "du", "/Users/rayperry/Desktop/complaint_manager/node_modules", :out;

my @usages;
for $command.out.lines {
    my $parsedInput = DiskUsage.parse($_);
    my $currentRecord = $parsedInput<record>.head;
    # TODO: Fix the (Any) objects getting pushed to the List.
    @usages.append: $currentRecord<usage> # %( value => $currentRecord<usage>.Int, path => $currentRecord<path>.Str );
}

# TODO: Still issues with this.
.say for @usages[^5];
# say @usages.sort: { $^a<value> - $^b<value> };

