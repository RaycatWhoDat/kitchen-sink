class PaginationHelper {
    has Str @.items;
    has Int $.limit;
    
    method page-count {
        round @!items.elems / $!limit;
    }
    
    method item-count { @!items.elems }

    method page-item-count(Int $page-number) {
        return Nil unless $page-number ~~ ^self.page-count;
        return $!limit if $page-number < self.page-count - 1;
        @!items.elems - ($!limit * $page-number);
    }

    method page-index(Int $item-index) {
        return Nil unless $item-index ~~ ^@!items.elems;
        $item-index.polymod($!limit).tail;
    }
}


DOC CHECK {
    use Test;
    
    my $helper = PaginationHelper.new(items => 'a'..'f', limit => 4);
    $helper.page-count.&is(2); # should == 2
    $helper.item-count.&is(6); # should == 6
    $helper.page-item-count(0).&is(4); # should == 4
    $helper.page-item-count(1).&is(2); #  last page - should == 2
    $helper.page-item-count(2).&is(Nil); #  should == -1 since the page is invalid

    #  pageIndex takes an item index and returns the page that it belongs on
    $helper.page-index(5).&is(1); # should == 1 (zero based index)
    $helper.page-index(2).&is(0); # should == 0
    $helper.page-index(20).&is(Nil); # should == -1
    $helper.page-index(-10).&is(Nil); # should == -1

    done-testing;
}                                                                       
 
                                                                       
