parsers-statements
tixeStatement
	^ super tixeStatement
		=>> [ :start :end :pair | 
			ViennaNode
				label: 'TixeStatement'
				start: start
				end: end
				withAll: pair ]