parsers-definitions
error
	^ super error
		=>> [ :start :end :array | 
			ViennaNode
				label: 'Error'
				start: start
				end: end
				withAll: array ]