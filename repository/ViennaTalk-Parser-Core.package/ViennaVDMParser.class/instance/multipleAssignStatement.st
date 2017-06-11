parsers-statements
multipleAssignStatement
	^ super multipleAssignStatement
		=>> [ :start :end :array | 
			ViennaNode
				label: 'MultipleAssignStatement'
				start: start
				end: end
				withAll: array ]