parsers-interfaces
exportFunctionsSignature
	^ super exportFunctionsSignature ==> [ :array | ViennaNode label: 'ExportFunctionsSignature' withAll: array ]