parsers-literals
char
	^ self escapeSequence / (($" asParser not , $' asParser not , #any asParser) ==> #third)