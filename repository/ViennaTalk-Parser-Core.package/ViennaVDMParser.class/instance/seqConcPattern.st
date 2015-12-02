parsers-patterns
seqConcPattern
	^ super seqConcPattern ==> [ :array | ViennaNode label: 'SeqConcPattern' withAll: array ]