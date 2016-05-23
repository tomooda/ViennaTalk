parsers-patterns
seqBind
	^ super seqBind ==> [ :array | ViennaNode label: 'SeqBind' withAll: array ]