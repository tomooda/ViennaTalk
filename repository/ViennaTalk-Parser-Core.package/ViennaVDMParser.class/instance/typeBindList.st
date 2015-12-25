parsers-patterns
typeBindList
	^ super typeBindList ==> [ :array | ViennaNode label: 'TypeBindList' withAll: array ]