parsers-patterns
fieldPattern
	^ super fieldPattern ==> [ :array | ViennaNode label: 'FieldPattern' withAll: array ]