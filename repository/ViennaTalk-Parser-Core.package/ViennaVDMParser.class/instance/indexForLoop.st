parsers-statements
indexForLoop
	^ super indexForLoop
		=>> [ :start :end :array | 
			ViennaNode
				label: 'IndexForLoop'
				start: start
				end: end
				withAll: array ]