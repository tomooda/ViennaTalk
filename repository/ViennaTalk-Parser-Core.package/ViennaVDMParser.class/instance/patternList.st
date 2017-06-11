parsers-patterns
patternList
	^ super patternList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'PatternList'
				start: start
				end: end
				withAll: array ]