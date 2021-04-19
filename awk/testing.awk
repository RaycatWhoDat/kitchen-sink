BEGIN {
    print "This is a quick test.";
}

/[^,]+/ {
    print $1
}
