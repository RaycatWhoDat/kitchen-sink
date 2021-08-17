Red []

format: function [record] [
	print [
		"Artist:" record/1 newline
		"Track Name:" record/2 newline
		"YouTube Link:" record/3 newline
	]
]

parse-rules: [
	collect [
		some [keep [to " - "] 3 skip]
		keep [to end]
	]
]

foreach line read/lines %songs.txt [
	format parse line parse-rules
]
