parsers-statements
traps
	^ super traps ==> [ :array | ViennaNode label: 'Traps' withAll: array ]