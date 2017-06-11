parsers-patterns
multipleSetBind
	^ super multipleSetBind
		=>> [ :start :end :array | 
			ViennaNode
				label: 'MultipleSetBind'
				start: start
				end: end
				withAll: array ]