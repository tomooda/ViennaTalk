parsers-patterns
patternIdentifier
	^ (self decl: identifier) trim / ((self operator: $-) ==> [ :op | nil ])