parsers-patterns
multipleSetBind
	^ super multipleSetBind ==> [ :array | ViennaNode label: 'MultipleSetBind' withAll: array ]