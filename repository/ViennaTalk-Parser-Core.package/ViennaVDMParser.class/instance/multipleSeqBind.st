parsers-patterns
multipleSeqBind
	^ super multipleSeqBind ==> [ :array | ViennaNode label: 'MultipleSeqBind' withAll: array ]