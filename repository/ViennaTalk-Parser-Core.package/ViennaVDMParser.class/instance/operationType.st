parsers-types
operationType
	^ super operationType
		=>> [ :start :end :array | 
			ViennaNode
				label: 'OperationType'
				start: start
				end: end
				withAll: array ]