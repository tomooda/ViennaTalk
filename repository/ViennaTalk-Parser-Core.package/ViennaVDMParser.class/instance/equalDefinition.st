parsers-definitions
equalDefinition
	^ super equalDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'EqualDefinition'
				start: start
				end: end
				withAll: array ]