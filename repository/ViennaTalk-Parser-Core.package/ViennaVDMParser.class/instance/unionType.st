parsers-types
unionType
	^ super unionType
		=>> [ :start :end :array | 
			ViennaNode
				label: 'UnionType'
				start: start
				end: end
				withAll: array ]