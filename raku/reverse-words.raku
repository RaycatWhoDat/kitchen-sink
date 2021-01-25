use v6;

sub prefix:<R>(Str $input) { $input.words.reverse.join(' ') };

DOC CHECK {
    use Test;
    subtest "Test case 1" => {
        my $result = R "The Weekly Challenge";
        $result.&is("Challenge Weekly The");
    }
    
    subtest "Test case 2" => {
        my $result = R "    Perl and   Raku are  part of the same family  ";
        $result.&is("family same the of part are Raku and Perl");
    }
}
