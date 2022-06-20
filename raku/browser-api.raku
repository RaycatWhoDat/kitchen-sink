# Design an API to handle the navigation history of a web browser
# (previous page, next page, list the 10 previous pages), and that can
# be reusable in many parts of the application (here I give concrete
# examples in our app).

class BrowserAPI {
    has @.entries = [];
    has $.index is rw = -1;

    method get-page($index = $.index) {
        return @.entries[$index];
    }
    
    method previous-page {
        return if $.index < 1;
        $.index--;
    }

    method next-page {
        return if $.index >= @.entries.elems;
        $.index++;
    }

    method list-ten-previous-pages {
        my $range = ($.index - 10) .. $.index;
        return if $range.bounds[0] < 0 or $range.bounds[1] > @.entries.elems;
        say self.get-page($_) for $range.list;
    }

    method navigate(Str $page-name) {
        @.entries.push: $page-name;
        $.index++;
    }
}

my $api = BrowserAPI.new;
$api.navigate("/$_") for 'a'..'z';
say $api.entries;
say $api.get-page;
$api.previous-page;
say $api.get-page;
$api.list-ten-previous-pages;
