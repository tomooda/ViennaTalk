parsers-definitions
invariant
	^ super invariant
		=>> [ :start :end :inv | 
			ViennaNode
				label: 'Invariant'
				start: start
				end: end
				with: inv ]