parsers-definitions
varInformation
	^ super varInformation ==> [ :array | ViennaNode label: 'VarInformation' withAll: array ]