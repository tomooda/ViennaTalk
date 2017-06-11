parsers-definitions
explicitFunctionDefinition
	^ super explicitFunctionDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ExplicitFunctionDefinition'
				start: start
				end: end
				withAll: array ]