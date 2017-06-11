parsers-definitions
stateDefinition
	^ super stateDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'StateDefinition'
				start: start
				end: end
				withAll: array ]