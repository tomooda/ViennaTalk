parsers-interfaces
functionSignature
	^ super functionSignature
		=>> [ :start :end :array | 
			ViennaNode
				label: 'FunctionSignature'
				start: start
				end: end
				withAll: array ]