$_ = q:to/END/;
<h1> Hello, world </h1>
<h1>Hello, world</h1>
END

my @matches = m:g/ \<\w+\> \V+ \<\/\w+\> /;

.say for @matches;
