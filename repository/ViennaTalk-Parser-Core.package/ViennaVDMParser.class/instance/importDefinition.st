parsers-interfaces
importDefinition
	^ super importDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ImportDefinition'
				start: start
				end: end
				withAll: array ]