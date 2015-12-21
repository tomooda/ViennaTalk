parsers-interfaces
functionImport
	^ super functionImport ==> [ :array | ViennaNode label: 'FunctionImport' withAll: array ]