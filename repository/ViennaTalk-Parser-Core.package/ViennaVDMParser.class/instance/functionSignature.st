parsers-interfaces
functionSignature
	^ super functionSignature ==> [ :array | ViennaNode label: 'FunctionSignature' withAll: array ]