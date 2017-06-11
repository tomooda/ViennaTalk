parsers-statements
trapStatement
	^ super trapStatement
		=>> [ :start :end :pair | 
			ViennaNode
				label: 'TrapStatement'
				start: start
				end: end
				withAll: pair ]