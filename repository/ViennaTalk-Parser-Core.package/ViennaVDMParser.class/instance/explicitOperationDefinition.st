parsers-definitions
explicitOperationDefinition
	^ super explicitOperationDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ExplicitOperationDefinition'
				start: start
				end: end
				withAll: array ]