parsers-patterns
seqEnumPattern
	^ super seqEnumPattern ==> [ :array | ViennaNode label: 'SeqEnumPattern' withAll: array ]