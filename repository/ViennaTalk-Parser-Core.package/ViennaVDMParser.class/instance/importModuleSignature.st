parsers-interfaces
importModuleSignature
	^ super importModuleSignature ==> [ :array | ViennaNode label: 'ImportModuleSignature' withAll: array ]