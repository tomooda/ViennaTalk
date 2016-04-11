parsers-literals
booleanLiteral
	^ ((('true' asParser , self endOfWord) ==> [ :t | true ]) / (('false' asParser , self endOfWord) ==> [ :t | false ]))
		trim