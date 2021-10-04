class Item {
    has Str $.name;
}

class Weapon is Item {
    our @all-weapons = [];
    
    has Int(Str) $.attack;
    has Int(Str) $.size;

    submethod TWEAK {
        @all-weapons.push: self.name unless self.name (elem) @all-weapons;
    }

    submethod get-all-weapons { @all-weapons; }

    submethod reload-all-weapons {
        @all-weapons = [];
        for './data/weapons.csv'.IO.lines.skip {
            next unless $_;
            my ($name, $attack, $size) = .split(',');
            Weapon.new: name => $name, attack => $attack, size => $size;
        }
    }
}

DOC CHECK {
    use Test;

    Weapon.reload-all-weapons;
    Weapon.get-all-weapons.&is(<Broadsword Sword Dagger Lance Slimeball>);
    
    done-testing;
}
