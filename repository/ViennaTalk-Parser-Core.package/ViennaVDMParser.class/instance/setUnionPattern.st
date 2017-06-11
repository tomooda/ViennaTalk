parsers-patterns
setUnionPattern
	^ super setUnionPattern
		=>> [ :start :end :array | 
			ViennaNode
				label: 'SetUnionPattern'
				start: start
				end: end
				withAll: array ]