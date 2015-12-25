parsers-patterns
patternIdentifier
	^ identifier trim / ((self operator: $-) ==> [ :op |  nil])