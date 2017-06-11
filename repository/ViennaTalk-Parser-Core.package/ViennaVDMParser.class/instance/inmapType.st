parsers-types
inmapType
	^ super inmapType
		=>> [ :start :end :array | 
			ViennaNode
				label: 'InmapType'
				start: start
				end: end
				withAll: array ]