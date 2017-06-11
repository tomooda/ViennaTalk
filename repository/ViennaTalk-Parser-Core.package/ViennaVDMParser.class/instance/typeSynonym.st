parsers-definitions
typeSynonym
	^ super typeSynonym
		=>> [ :start :end :array | 
			ViennaNode
				label: 'TypeDefinition'
				start: start
				end: end
				withAll: array ]