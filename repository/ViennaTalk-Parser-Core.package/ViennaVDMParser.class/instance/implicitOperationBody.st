parsers-definitions
implicitOperationBody
	^ super implicitOperationBody ==> [ :array | ViennaNode label: 'ImplicitOperationBody' withAll: array ]