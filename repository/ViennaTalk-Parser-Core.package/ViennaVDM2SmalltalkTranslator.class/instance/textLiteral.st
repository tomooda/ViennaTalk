parsers-literals
textLiteral
	^ super textLiteral ==> [ :text | text asOrderedCollection storeString ]