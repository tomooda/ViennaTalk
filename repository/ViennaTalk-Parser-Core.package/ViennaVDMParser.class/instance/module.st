parsers-definitions
module
	^ super module
		=>> [ :start :end :array | 
			ViennaNode
				label: 'Module'
				start: start
				end: end
				withAll: array ]