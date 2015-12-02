parsers-patterns
recordPattern
	^ super recordPattern ==> [ :array | ViennaNode label: 'RecordPattern' withAll: array ]