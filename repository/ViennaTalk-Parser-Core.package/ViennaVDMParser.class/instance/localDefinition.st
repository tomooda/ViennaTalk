parsers-definitions
localDefinition
	^ super localDefinition
		=>> [ :start :end :def | 
			ViennaNode
				label: 'LocalDefinition'
				start: start
				end: end
				with: def ]