parsers-patterns
tuplePattern
	^ super tuplePattern
		=>> [ :start :end :array | 
			ViennaNode
				label: 'TuplePattern'
				start: start
				end: end
				with: (ViennaNode label: 'PatternList' withAll: array) ]