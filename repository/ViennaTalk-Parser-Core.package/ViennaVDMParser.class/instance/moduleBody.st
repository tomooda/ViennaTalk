parsers-definitions
moduleBody
	^ super moduleBody ==> [ :array | ViennaNode label: 'ModuleBody' withAll: array ]