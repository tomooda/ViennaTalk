parsers-definitions
equalDefinitionList
	^ super equalDefinitionList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'EqualDefinitionList'
				start: start
				end: end
				withAll: array ]