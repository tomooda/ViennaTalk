parsers-definitions
implicitOperationDefinition
	^ super implicitOperationDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ImplicitOperationDefinition'
				start: start
				end: end
				withAll: array ]