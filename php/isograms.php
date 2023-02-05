<?php

$testCases = ['lumberjacks', 'background', 'downstream', 'six-year-old', 'isograms'];
$results = [];

foreach ($testCases as $testCase)
{
    $chars = str_split(preg_replace('/\ |\-/', '', $testCase));
    $results[] = count($chars) == count(array_unique($chars)) ? 'true' : 'false';
}

echo(implode(', ', $results));

?>
