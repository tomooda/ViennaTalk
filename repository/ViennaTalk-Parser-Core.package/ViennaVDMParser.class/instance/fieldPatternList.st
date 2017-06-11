parsers-patterns
fieldPatternList
	^ super fieldPatternList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'FieldPatternList'
				start: start
				end: end
				withAll: array ]