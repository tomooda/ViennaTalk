parsers-definitions
accessFunctionDefinition
	^ super accessFunctionDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'AccessFunctionDefinition'
				start: start
				end: end
				with: (ViennaNode label: 'Access' withAll: array first)
				with: array second ]