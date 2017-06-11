parsers-definitions
valueDefinition
	^ super valueDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ValueDefinition'
				start: start
				end: end
				withAll: array ]