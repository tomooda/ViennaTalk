parsers-literals
textLiteral
	^ super textLiteral ==> [ :text | text asArray storeString ]