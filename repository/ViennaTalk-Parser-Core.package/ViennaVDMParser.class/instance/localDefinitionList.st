parsers-definitions
localDefinitionList
	^ super localDefinitionList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'LocalDefinitionList'
				start: start
				end: end
				withAll: array ]