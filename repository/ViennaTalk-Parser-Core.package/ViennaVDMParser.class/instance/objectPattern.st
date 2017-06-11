parsers-patterns
objectPattern
	^ super objectPattern
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ObjectPattern'
				start: start
				end: end
				withAll: array ]