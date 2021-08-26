Red []

format: function [record] [
	print [
		"Artist:" record/1 newline
		"Track Name:" record/2 newline
		"YouTube Link:" record/3 newline
	]
]

fields: [some [keep to " - " 3 skip]]
last-field: [keep to end]

foreach line read/lines %data/songs.txt [
	format parse line [collect [fields last-field]]
]
