parsers-definitions
document
	^ super document ==> [ :array | ViennaNode label: 'Document' withAll: array ]