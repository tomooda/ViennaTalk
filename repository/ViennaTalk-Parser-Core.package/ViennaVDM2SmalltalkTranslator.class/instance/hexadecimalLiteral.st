parsers-literals
hexadecimalLiteral
	^ super hexadecimalLiteral ==> [ :hex | '16r' , hex ]