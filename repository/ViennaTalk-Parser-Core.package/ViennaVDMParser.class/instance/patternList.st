parsers-patterns
patternList
	^ super patternList ==> [ :array | ViennaNode label: 'PatternList' withAll: array ]