parsers-statements
assignmentDefinition
	^ super assignmentDefinition ==> [ :array | ViennaNode label: 'AssignmentDefinition' withAll: array ]