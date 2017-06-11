parsers-types
mapType
	^ super mapType
		=>> [ :start :end :array | 
			ViennaNode
				label: 'MapType'
				start: start
				end: end
				withAll: array ]