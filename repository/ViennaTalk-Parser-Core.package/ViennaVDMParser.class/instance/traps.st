parsers-statements
traps
	^ super traps
		=>> [ :start :end :array | 
			ViennaNode
				label: 'Traps'
				start: start
				end: end
				withAll: array ]