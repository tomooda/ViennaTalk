parsers-patterns
fieldPattern
	^ super fieldPattern
		=>> [ :start :end :array | 
			ViennaNode
				label: 'FieldPattern'
				start: start
				end: end
				withAll: array ]