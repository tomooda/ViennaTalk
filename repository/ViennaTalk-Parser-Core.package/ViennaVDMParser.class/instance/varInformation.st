parsers-definitions
varInformation
	^ super varInformation
		=>> [ :start :end :array | 
			ViennaNode
				label: 'VarInformation'
				start: start
				end: end
				withAll: array ]