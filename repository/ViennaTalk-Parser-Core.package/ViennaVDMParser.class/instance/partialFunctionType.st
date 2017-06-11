parsers-types
partialFunctionType
	^ super partialFunctionType
		=>> [ :start :end :array | 
			ViennaNode
				label: 'PartialFunctionType'
				start: start
				end: end
				withAll: array ]