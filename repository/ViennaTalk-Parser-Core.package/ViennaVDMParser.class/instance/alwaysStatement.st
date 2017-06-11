parsers-statements
alwaysStatement
	^ super alwaysStatement
		=>> [ :start :end :pair | 
			ViennaNode
				label: 'AlwaysStatement'
				start: start
				end: end
				withAll: pair ]