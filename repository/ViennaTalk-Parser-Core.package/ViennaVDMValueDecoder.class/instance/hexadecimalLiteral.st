parsers-expressions
hexadecimalLiteral
	^ ($- asParser optional , super hexadecimalLiteral) trim
		==> [ :pair | 
			| nat |
			nat := Integer readFrom: pair second radix: 16.
			pair first ifNotNil: [ nat := nat negated ].
			nat ]