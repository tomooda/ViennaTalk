parsers-expressions-basics
recordConstructor
	^ super recordConstructor ==> [ :array | ViennaNode label: 'RecordConstructor' withAll: array ]