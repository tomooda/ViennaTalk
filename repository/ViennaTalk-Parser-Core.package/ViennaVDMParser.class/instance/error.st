parsers-definitions
error
	^ super error ==> [ :array | ViennaNode label: 'Error' withAll: array ]