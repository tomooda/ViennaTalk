parsers-expressions
hexadecimalLiteral
	^ super hexadecimalLiteral ==> [ :hex | Integer readFrom: hex radix: 16 ]