class Account {
    my $_number = 1;
    has Int $.number;
    has $.balance is rw = 0;

    submethod BUILD(:$balance) {
        $!balance = $balance;
        $!number = $_number;
    }

    submethod TWEAK {
        $!number = $_number++;
    }
}

multi infix:<+>(Account:D $firstAccount, Account:D $secondAccount) {
    $firstAccount.balance = $firstAccount.balance + $secondAccount.balance;
    $secondAccount.balance = 0;
}

my $firstAccount = Account.new(balance => 20);
my $secondAccount = Account.new(balance => 40);

say $firstAccount;
say $secondAccount;

sink $firstAccount + $secondAccount;

say $firstAccount;
say $secondAccount;
