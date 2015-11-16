parsers-literals
characterLiteral
	^ super characterLiteral ==> [ :c | c storeString ]