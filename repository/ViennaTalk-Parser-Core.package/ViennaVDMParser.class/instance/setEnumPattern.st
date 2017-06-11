parsers-patterns
setEnumPattern
	^ super setEnumPattern
		=>> [ :start :end :array | 
			ViennaNode
				label: 'SetEnumPattern'
				start: start
				end: end
				withAll: array ]