parsers-definitions
identifierTypePair
	^ super identifierTypePair
		=>> [ :start :end :pair | 
			ViennaNode
				label: 'IdentifierTypePair'
				start: start
				end: end
				withAll: pair ]