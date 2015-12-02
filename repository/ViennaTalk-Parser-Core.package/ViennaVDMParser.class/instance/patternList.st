parsers-patterns
patternList
	^ super patternList ==> [ :array | ViennaNode label: 'PatternList' with: array ]