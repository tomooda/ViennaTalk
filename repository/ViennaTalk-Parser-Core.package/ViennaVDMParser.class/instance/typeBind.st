parsers-patterns
typeBind
	^ super typeBind
		=>> [ :start :end :array | 
			ViennaNode
				label: 'TypeBind'
				start: start
				end: end
				withAll: array ]