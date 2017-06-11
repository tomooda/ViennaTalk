parsers-definitions
errorList
	^ super errorList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ErrorList'
				start: start
				end: end
				withAll: array ]