parsers-patterns
patternIdentifier
	^ identifier / ((self operator: $-) ==> [ :op |  ])