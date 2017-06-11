parsers-types
totalFunctionType
	^ super totalFunctionType
		=>> [ :start :end :array | 
			ViennaNode
				label: 'TotalFunctionType'
				start: start
				end: end
				withAll: array ]