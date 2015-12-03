parsers-patterns
fieldPatternList
	^ super fieldPattern ==> [ :array | ViennaNode label: 'FieldPatternList' withAll: array ]