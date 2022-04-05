sub remove-geese(@birds) {
    my @geese = "African", "Roman Tufted", "Toulouse", "Pilgrim", "Steinbacher";
    @birds.grep: * !(elem) @geese
}

DOC CHECK {
    use Test;

    my @test-case = "Mallard", "Hook Bill", "African", "Crested", "Pilgrim", "Toulouse", "Blue Swedish";

    remove-geese(@test-case).&is(("Mallard", "Hook Bill", "Crested", "Blue Swedish"));
    
    done-testing;
}

