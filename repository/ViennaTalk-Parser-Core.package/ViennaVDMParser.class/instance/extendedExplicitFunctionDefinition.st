parsers-definitions
extendedExplicitFunctionDefinition
	^ super extendedExplicitFunctionDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ExtendedExplicitFunctionDefinition'
				start: start
				end: end
				withAll: array ]