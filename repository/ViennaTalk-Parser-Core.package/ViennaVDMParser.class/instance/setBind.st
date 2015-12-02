parsers-patterns
setBind
	^ super setBind ==> [ :array | ViennaNode label: 'SetBind' withAll: array ]