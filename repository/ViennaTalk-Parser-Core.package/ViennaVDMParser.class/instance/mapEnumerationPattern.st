parsers-patterns
mapEnumerationPattern
	^ super mapEnumerationPattern
		=>> [:start :end :array | 
			ViennaNode
				label: 'MapEnumerationPattern'
				 start: start end: end 
				withAll: array ]