parsers-patterns
bindList
	^ super bindList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'BindList'
				start: start
				end: end
				withAll: array ]