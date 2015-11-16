parsers-patterns
matchValue
	^ ((lparen , expression , rparen) ==> #second) / symbolicLiteral