parsers-expressions-basics
tokenConstructor
	^ super tokenConstructor ==> [ :array | ViennaNode label: 'TokenConstructor' with: array ]