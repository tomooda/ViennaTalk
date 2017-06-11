parsers-statements
assignmentDefinition
	^ super assignmentDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'AssignmentDefinition'
				start: start
				end: end
				withAll: array ]