parsers-types
stateFieldList
	^ super stateFieldList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'FieldList'
				start: start
				end: end
				withAll: array ]