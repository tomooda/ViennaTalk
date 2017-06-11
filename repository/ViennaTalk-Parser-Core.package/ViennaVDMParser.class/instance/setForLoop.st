parsers-statements
setForLoop
	^ super setForLoop
		=>> [ :start :end :array | 
			ViennaNode
				label: 'SetForLoop'
				start: start
				end: end
				withAll: array ]