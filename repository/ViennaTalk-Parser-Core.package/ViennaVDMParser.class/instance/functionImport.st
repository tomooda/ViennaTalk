parsers-interfaces
functionImport
	^ super functionImport ==> [ :array | ViennaNode label: 'FunctionImport' with: array first with: (ViennaNode label: 'FunctionImportType' withAll: array second) with: array third]