parsers-patterns
mapMunionPattern
	^ super mapMunionPattern
		=>> [ :start :end :array | 
			ViennaNode
				label: 'MapMunionPattern'
				start: start
				end: end
				withAll: array ]