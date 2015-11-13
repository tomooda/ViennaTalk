parsers-patterns
matchValue
	^ (((self operator: $() , expression , (self operator: $))) ==> #second) / symbolicLiteral