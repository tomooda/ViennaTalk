parsers-patterns
objectPattern
	^ super objectPattern ==> [ :array | ViennaNode label: 'ObjectPattern' withAll: array ]