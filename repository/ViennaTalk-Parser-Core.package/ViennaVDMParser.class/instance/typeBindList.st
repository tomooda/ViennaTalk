parsers-patterns
typeBindList
	^ super typeBindList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'TypeBindList'
				start: start
				end: end
				withAll: array ]