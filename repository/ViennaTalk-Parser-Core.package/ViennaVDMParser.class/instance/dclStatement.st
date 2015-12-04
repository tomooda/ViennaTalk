parsers-statements
dclStatement
	^ super dclStatement ==> [ :array | ViennaNode label: 'DclStatement' withAll: array ]