parsers-patterns
patternList
	^ (pattern separatedBy: (self operator: $,)) withoutSeparators