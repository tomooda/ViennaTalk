parsers-patterns
typeBind
	^ super typeBind ==> [ :array | ViennaNode label: 'TypeBind' withAll: array ]