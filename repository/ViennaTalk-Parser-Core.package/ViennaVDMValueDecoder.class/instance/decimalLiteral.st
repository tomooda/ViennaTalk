parsers-expressions
decimalLiteral
	^ ($- asParser optional , super decimalLiteral) flatten trim ==> [ :str | str trim asNumber ]