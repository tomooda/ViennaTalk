parsers-types
invariantInitialFunction
	^ super invariantInitialFunction
		=>> [ :start :end :array | 
			ViennaNode
				label: 'InvariantInitialFunction'
				start: start
				end: end
				withAll: array ]