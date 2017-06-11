parsers-definitions
accessValueDefinition
	^ super accessValueDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'AccessValueDefinition'
				start: start
				end: end
				with: (ViennaNode label: 'Access' withAll: array first)
				with: array second ]