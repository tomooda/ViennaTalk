parsers-literals
nilLiteral
	^ ('nil' asParser , self endOfWord) trim ==> [ :t | nil ]