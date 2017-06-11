parsers-patterns
multipleTypeBind
	^ super multipleTypeBind
		=>> [ :start :end :array | 
			ViennaNode
				label: 'MultipleTypeBind'
				start: start
				end: end
				withAll: array ]