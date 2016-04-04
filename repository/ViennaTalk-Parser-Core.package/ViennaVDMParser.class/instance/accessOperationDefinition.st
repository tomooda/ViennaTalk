parsers-definitions
accessOperationDefinition
	^ super accessOperationDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'AccessOperationDefinition'
				start: start
				end: end
				with: (ViennaNode label: 'Access' withAll: array first)
				with: array second ]