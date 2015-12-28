parsers-expressions
hexadecimalLiteral
	^ ($- asParser optional , super hexadecimalLiteral) flatten trim ==> [ :hex | Integer readFrom: hex radix: 16 ]