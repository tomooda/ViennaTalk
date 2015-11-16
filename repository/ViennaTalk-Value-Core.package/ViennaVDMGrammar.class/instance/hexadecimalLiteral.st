parsers-literals
hexadecimalLiteral
	^ (('0x' asParser / '0X' asParser , #hex asParser plus flatten) ==> #second) trim