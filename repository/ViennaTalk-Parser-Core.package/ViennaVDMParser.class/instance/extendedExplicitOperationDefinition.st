parsers-definitions
extendedExplicitOperationDefinition
	^ super extendedExplicitOperationDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ExtendedExplicitOperationDefinition'
				start: start
				end: end
				withAll: array ]