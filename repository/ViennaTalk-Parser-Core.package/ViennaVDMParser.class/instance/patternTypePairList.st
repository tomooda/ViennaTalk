parsers-definitions
patternTypePairList
	^ super patternTypePairList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'PatternTypePairList'
				start: start
				end: end
				withAll: array ]