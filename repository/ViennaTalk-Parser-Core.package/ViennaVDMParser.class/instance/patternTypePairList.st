parsers-definitions
patternTypePairList
	^ super patternTypePairList
		==> [ :array | ViennaNode label: 'PatternTypePairList' withAll: array ]