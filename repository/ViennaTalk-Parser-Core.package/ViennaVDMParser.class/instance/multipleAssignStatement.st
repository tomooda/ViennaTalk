parsers-statements
multipleAssignStatement
	^ super multipleAssignStatement ==> [ :array | ViennaNode label: 'MultipleAssignStatement' withAll: array ]