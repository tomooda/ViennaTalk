parsers-definitions
implicitFunctionDefinition
	^ super implicitFunctionDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ImplicitFunctionDefinition'
				start: start
				end: end
				withAll: array ]