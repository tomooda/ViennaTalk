parsers-interfaces
functionExport
	^ super functionExport ==> [ :array | ViennaNode label: 'FunctionExport' withAll: array ]