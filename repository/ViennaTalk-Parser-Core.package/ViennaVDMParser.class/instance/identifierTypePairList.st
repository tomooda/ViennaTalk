parsers-definitions
identifierTypePairList
	^ super identifierTypePairList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'IdentifierTypePairList'
				start: start
				end: end
				withAll: array ]