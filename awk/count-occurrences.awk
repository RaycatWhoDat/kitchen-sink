BEGIN {
    print "Counting the number of occurrences of TXR...";

    count = 0;
}

/TXR/ {
    count += gsub("TXR", "TXR");
}

END {
    print count;
}
