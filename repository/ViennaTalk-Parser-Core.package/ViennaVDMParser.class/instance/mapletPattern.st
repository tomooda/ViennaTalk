parsers-patterns
mapletPattern
	^ super mapletPattern
		=>> [ :start :end :array | 
			ViennaNode
				label: 'MapletPattern'
				start: start
				end: end
				withAll: array ]