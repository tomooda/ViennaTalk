parsers-patterns
multipleTypeBind
	^ super multipleTypeBind ==> [ :array | ViennaNode label: 'MultipleTypeBind' withAll: array ]