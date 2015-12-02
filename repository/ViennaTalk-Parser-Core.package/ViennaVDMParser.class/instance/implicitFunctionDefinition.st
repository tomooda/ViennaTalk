parsers-definitions
implicitFunctionDefinition
	^ super implicitFunctionDefinition ==> [ :array | ViennaNode label: 'ImplicitFunctionDefinition' withAll: array ]