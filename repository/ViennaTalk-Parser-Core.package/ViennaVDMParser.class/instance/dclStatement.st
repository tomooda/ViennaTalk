parsers-statements
dclStatement
	^ super dclStatement
		=>> [ :start :end :array | 
			ViennaNode
				label: 'DclStatement'
				start: start
				end: end
				withAll: array ]