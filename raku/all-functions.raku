for "../txr/docs/manpage.html".IO.lines {
    m/ 'class="tocanchor">' (.+) '</a> <a href="' [.+?] '">' (.+) '</a></dt>' /;
    next unless so $/;
    say "$0 - $1";
}
