parsers-expressions
quoteLiteral
	^ super quoteLiteral ==> [ :quote | quote asSymbol ]