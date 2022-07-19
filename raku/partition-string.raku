sub partition-string($numberOfChars, $replacementChar, $string) {
    $string.comb($numberOfChars).join($replacementChar);
}

say partition-string(3, "/", "this is a test");
