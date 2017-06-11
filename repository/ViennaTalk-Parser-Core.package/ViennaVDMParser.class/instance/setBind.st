parsers-patterns
setBind
	^ super setBind
		=>> [ :start :end :array | 
			ViennaNode
				label: 'SetBind'
				start: start
				end: end
				withAll: array ]