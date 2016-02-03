parsers-expressions
quoteLiteral
	^ super quoteLiteral ==> [ :quote | (quote copyFrom: 2 to: quote size - 1) asSymbol ]