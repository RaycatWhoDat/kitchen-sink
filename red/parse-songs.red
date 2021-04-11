Red []

format: function [record] [
	print [
		"Artist:" record/1 newline
		"Track Name:" record/2 newline
		"YouTube Link:" record/3 newline
	]
]

delimiter: [space "-" space]
skip-length: length? delimiter

parse-rules: [
	collect [
		keep [to delimiter]
		skip-length skip
		keep [to delimiter]
		skip-length skip
		keep [to end]
	]
]

foreach line read/lines %songs.txt [
	format parse line parse-rules
]