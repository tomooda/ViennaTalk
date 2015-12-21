parsers-interfaces
typeImport
	^ super typeImport ==> [ :array | ViennaNode label: 'TypeImport' withAll: array ]