parsers-expressions
decimalLiteral
	^ super decimalLiteral ==> [ :str | str asNumber ]