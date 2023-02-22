class Question {
    has Str $.answer;
    has Str $.text;
}

my @questions of Question =
    Question.new(text => "This is a test. What is the answer?\n", answer => "A"),
    Question.new(text => "This is another test. Why is the answer?\n", answer => "B"),
    Question.new(text => "This is the final test. How is the answer?\n", answer => "C");

my $correct-answers = 0;

$correct-answers++ if (prompt .text) eq .answer for @questions;

printf(
    "%i out of %i correct\nPercentage: %.2f%%\n",
    $correct-answers,
    @questions.elems,
    100.0 * $correct-answers / @questions.elems
);

