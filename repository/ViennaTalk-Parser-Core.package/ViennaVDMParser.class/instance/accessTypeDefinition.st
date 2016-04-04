parsers-definitions
accessTypeDefinition
	^ super accessTypeDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'AccessTypeDefinition'
				start: start
				end: end
				with: (ViennaNode label: 'Access' withAll: array first)
				with: array second ]