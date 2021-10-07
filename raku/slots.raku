class UserAccount {
    has $.current-balance is rw = 100_000;
}

enum SlotSymbol <TEN J Q K A SCROLL URN HELMET PEGASUS ATHENA>;

class SlotMachine {
    has $!reel-height = 5;
    has $!number-of-reels = 6;
    has $!minimum-of-winning-reels = 4;
    has $!minimum-bet = 100;
    has $!current-bet = 100_000;
    has $!maximum-bet = 100_000;
    has $!max-multiplier = 5_000;
    has %!payout-table = {
        TEN => (0.15, 0.20, 0.30),
        J => (0.20, 0.30, 0.40),
        Q => (0.30, 0.40, 0.50),
        K => (0.25, 0.50, 1),
        A => (0.50, 1, 2),
        SCROLL => (3, 5, 10),
        URN => (10, 25, 50),
        HELMET => (50, 100, 200),
        PEGASUS => (250, 500, 1_000),
        ATHENA => (500, 2_500, $!max-multiplier)
    }

    has @!all-reels = %!payout-table.keys xx $!number-of-reels;
    has $.number-of-spins is rw = 0;
    has @!last-spin;
    has $!last-payout;

    method can-spin(UserAccount $user-account) {
        $user-account.current-balance >= $!current-bet;
    }
    
    method spin(UserAccount $user-account) {
        unless self.can-spin($user-account) {
            say "Not enough credits to spin.";
            return;
        }
        
        $user-account.current-balance -= $!current-bet;
        $.number-of-spins++;
        @!last-spin = (.pick($!reel-height).Slip for @!all-reels).rotor($!number-of-reels);
        self.check-for-win($user-account);
    }

    method check-for-win(UserAccount $user-account) {
        my @winning-symbols = @!last-spin.first.unique;
        my $number-of-winning-reels = 1;
        my @possible-wins = gather for @!last-spin[2 .. *] -> @reel {
            my @next-wins = @winning-symbols.grep({ $_ (<=) @reel.unique });
            last if @next-wins.elems < 1;
            $number-of-winning-reels++;
            @winning-symbols = @next-wins;
            take @reel;
        }

        $!last-payout = 0;
        my @multipliers = [0];

        if $number-of-winning-reels >= $!minimum-of-winning-reels {
            say "Won on {@winning-symbols.join(', ')} across $number-of-winning-reels reels!";
            
            @multipliers = [
                %!payout-table{$_}[$number-of-winning-reels - $!minimum-of-winning-reels] for @winning-symbols
            ];
        }
        
        $!last-payout = [+] @multipliers.map: * * $!current-bet;
        say "Current bet: \${$!current-bet / 100}";
        say "Multipliers: {@multipliers.map: * ~ 'x' }";
        say "Payout: \${$!last-payout / 100}";
        $user-account.current-balance += $!last-payout;
        say "Current balance: \${$user-account.current-balance / 100}";
        say "==========";
    }
}

my $slot-machine = SlotMachine.new;
my $user-account = UserAccount.new;

loop {
    last unless $slot-machine.can-spin($user-account) and $slot-machine.number-of-spins <= 10;
    $slot-machine.spin($user-account);
}

say "Total number of spins: {$slot-machine.number-of-spins}";
